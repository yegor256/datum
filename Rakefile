# encoding: utf-8

# Copyright (c) 2016-2017 Zerocracy
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to read
# the Software only. Permissions is hereby NOT GRANTED to use, copy, modify,
# merge, publish, distribute, sublicense, and/or sell copies of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'nokogiri'
require 'rake'
require 'rake/clean'
require 'date'
require 'differ'
require 'tmpdir'
require 'fileutils'
require 'rake/clean'
require 'redcarpet'
require 'mustache'

CLEAN.include 'target'

task default: %i[clean xsd xsl pages style underscores rubocop copyright]

require 'rubocop/rake_task'
desc 'Run RuboCop on all directories'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
  task.requires << 'rubocop-rspec'
end

desc 'Enlist all upgrades and generate _list files'
task :enlist_upgrades do
  Dir['upgrades/**/*.xsl'].map { |f| File.dirname(f) }.uniq.each do |dir|
    File.write(
      dir + '/list',
      Dir[dir + '/*.xsl'].sort.map do |f|
        File.basename(f).gsub(/-.*$/, '') + ' ' + f + "\n"
      end.join('')
    )
  end
end

desc 'Generate HTML pages from Markdown'
task :pages do
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  dir = FileUtils.mkdir_p('target/pages')
  template = File.read('md/_template.html')
  Dir['md/*.md'].each do |md|
    file = File.join(dir, File.basename(md).gsub(/\.md$/, '.html'))
    File.write(
      file,
      Mustache.render(
        template,
        body: markdown.render(File.read(md)),
        name: File.basename(md).gsub(/\.md$/, '').capitalize,
        version: ENV['tag'],
        date: Time.new.strftime('%-d-%b-%Y')
      )
    )
    puts "HTML page created: #{file}"
  end
end

desc 'Validate all XML/XSD files'
task :xsd do
  total = 0
  Dir.mktmpdir do |temp|
    FileUtils.cp_r('xsd/', temp)
    Dir[temp + '/**/*.xsd'].each do |f|
      File.write(
        f,
        File.read(f).gsub(
          'http://datum.zerocracy.com/SNAPSHOT/xsd',
          temp + '/xsd'
        )
      )
    end
    Dir['xml/**/*.xml'].each do |p|
      print "Checking #{p}... "
      f = p.sub(%r{xml/}, temp + '/xsd/').sub(%r{/[^/]+\.xml$}, '.xsd')
      begin
        xsd = Nokogiri::XML::Schema(File.open(f))
      rescue Nokogiri::XML::SyntaxError => e
        print "\n#{f} #{e.line}: #{e.message}"
        raise 'XSD is invalid'
      end
      ok = true
      xml = Nokogiri::XML(File.read(p))
      path = p.gsub(%r{^xml/}, 'upgrades/').gsub(%r{/[^/]+$}, '/*.xsl')
      Dir[path].each do |x|
        xml = Nokogiri::XSLT(File.read(x)).transform(xml)
      end
      if File.basename(p).start_with?('-')
        if xsd.validate(xml).empty?
          print "#{p} no errors, but we are expecting some\n"
          total += 1
          ok = false
        end
      else
        xsd.validate(xml).each do |error|
          puts "\n#{p} #{error.line}: #{error.message}"
          total += 1
          ok = false
        end
      end
      print "OK\n" if ok
    end
  end
  raise "#{total} errors" unless total.zero?
  puts 'All XML/XSD files are clean'
end

desc 'Validate all XML/XSL files'
task :xsl do
  Dir['xml/**/*.xml'].each do |p|
    print "XML #{p}... "
    f = p.sub(%r{xml/}, 'xsl/').sub(%r{/([^/]+)\.xml$}, '.xsl')
    raise "XSL #{f} is absent" unless File.exist?(f)
    print "has XSL: #{f}\n"
  end
  dir = FileUtils.mkdir_p('target/views')
  FileUtils.rm_rf(File.join(dir, 'index.html'))
  total = 0
  Dir['xsl/**/*.xsl'].each do |p|
    next if File.basename(p).start_with?('_')
    print "Rendering #{p}... "
    f = p.sub(%r{xsl/}, 'xml/').sub(%r{/([^/]+)\.xsl$}, '/\1/simple.xml')
    begin
      xslt = Nokogiri::XSLT(File.open(p))
      label = p.sub(%r{.+/([^/]+)\.xsl$}, '\1.html')
      xml = Nokogiri::XML(File.open(f))
      root = xml.xpath('/*').first
      raise "version and updated attributes are required <#{f}>" if
        root.attr('version').nil? || root.attr('updated').nil?
      html = xslt.transform(Nokogiri::XML(File.open(f)))
      html.remove_namespaces!
      raise 'HTML <section> absent' if html.xpath('/html/body/section').empty?
      File.write(File.join(dir, label), html)
      open(File.join(dir, 'index.html'), 'a') do |i|
        i.puts "<p><a href='#{label}'>#{p}</a></p>"
      end
      print "OK\n"
    end
  end
  raise "#{total} errors" unless total.zero?
  puts 'All XML/XSL files are clean'
end

desc 'Validate all XML/XSL/XSD/HTML files for formatting'
task :style do
  Differ.format = :color
  license = [
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<!--',
    *File.read('LICENSE').strip
      .split(/\n/)
      .map { |t| " #{t}" }
      .map(&:rstrip)
      .map { |t| " *#{t}" },
    ' -->'
  ].join("\n")
  Dir['**/*.xml', '**/*.xsl', '**/*.xsd', '**/*.html'].each do |f|
    next if f.start_with?('target/')
    print "XML #{f}... "
    xml = Nokogiri::XML(File.open(f), &:noblanks)
    ideal = xml.to_xml(indent: 2)
    now = File.read(f)
    if now != ideal
      puts Differ.diff_by_line(ideal, now).to_s
      raise "XML formatting is broken in #{f}"
    end
    unless now.start_with?(license)
      puts Differ.diff_by_line(license, now).to_s
      raise "License in the header is broken in #{f}"
    end
    print "OK\n"
  end
  puts 'All XML/XSL/XSD/HTML files are formatted correctly'
end

desc 'Make sure no files start with an underscore'
task :underscores do
  Dir['**/*.xml', '**/*.xsl', '**/*.xsd'].each do |f|
    next if f.start_with?('target/')
    raise "#{f} won't be rendered by GitHub Pages" \
      if File.basename(f).start_with?('_')
  end
end

task :copyright do
  sh "grep -q -r '2016-#{Date.today.strftime('%Y')}' \
    --include '*.rb' \
    --include '*.xml' \
    --include '*.xsd' \
    --include '*.txt' \
    --include 'Rakefile' \
    ."
end
