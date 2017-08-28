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
require 'tmpdir'
require 'fileutils'
require 'rake/clean'
require 'redcarpet'
require 'mustache'
require 'time'
require 'rainbow'

CLEAN.include 'target'

task default: %i[clean xsd xsl auto xcop underscores rubocop copyright]

desc 'Validate all XML/XSD files'
task :xsd do
  total = 0
  puts 'Checking XML files for XSD validity...'
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
    xmls = Dir['xml/**/*.xml']
    xmls.each do |p|
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
      print Rainbow('.').green if ok
    end
    raise "#{total} errors" unless total.zero?
    puts "\nAll #{xmls.length} XML/XSD files are clean\n\n"
  end
end

desc 'Validate all XML/XSL files'
task :xsl do
  puts 'Checking XML and XSL files...'
  Dir['xml/**/*.xml'].each do |p|
    f = p.sub(%r{xml/}, 'xsl/').sub(%r{/([^/]+)\.xml$}, '.xsl')
    raise "XSL #{f} is absent" unless File.exist?(f)
  end
  dir = FileUtils.mkdir_p('target/views')
  FileUtils.rm_rf(File.join(dir, 'index.html'))
  total = 0
  xsls = Dir['xsl/**/*.xsl']
  xsls.each do |p|
    next if File.basename(p) == 'templates.xsl'
    f = p.sub(%r{xsl/}, 'xml/').sub(%r{/([^/]+)\.xsl$}, '/\1/simple.xml')
    begin
      xslt = Nokogiri::XSLT(File.open(p))
      label = p.sub(%r{.+/([^/]+)\.xsl$}, '\1.html')
      xml = Nokogiri::XML(File.open(f))
      root = xml.xpath('/*').first
      raise "version and updated attributes are required <#{f}>" if
        root.attr('version').nil? || root.attr('updated').nil?
      html = xslt.transform(
        Nokogiri::XML(File.open(f)),
        ['today', "'#{Time.now.iso8601}'"]
      )
      html.remove_namespaces!
      raise 'HTML <section> absent' if html.xpath('/html/body/section').empty?
      File.write(File.join(dir, label), html)
      open(File.join(dir, 'index.html'), 'a') do |i|
        i.puts "<p><a href='#{label}'>#{p}</a></p>"
      end
      print Rainbow('.').green
    end
  end
  raise "#{total} errors" unless total.zero?
  puts "\nAll #{xsls.length} XML/XSL files are clean\n\n"
end

desc 'Run all auto-updates and check their results'
task :auto do
  puts 'Testing auto-updates...'
  Dir.mktmpdir do |temp|
    FileUtils.cp_r('auto-test/', temp)
    Dir[File.join(temp, 'auto-test/**/_asserts.xml')].each do |p|
      dir = p.gsub(%r{.*auto-test/(.+)/_asserts.xml$}, '\1')
      home = Dir.pwd
      area = dir.gsub(%r{([a-z]+)/.+}, '\1')
      Dir["auto/#{area}/**/*.xsl"]
        .sort_by! { |x| x.gsub(/^([0-9]+)-.+$/, '\1').to_i }
        .each do |xsl|
          Dir.chdir(File.join(temp, "auto-test/#{dir}")) do
            target = xsl.gsub(%r{^.+/[0-9]+-([a-z]+)-.+$}, '\1.xml')
            xslt = Nokogiri::XSLT(File.read(File.join(home, xsl)))
            xml = Nokogiri::XML(File.read(target))
            File.write(target, xslt.transform(xml))
          end
        end
      Nokogiri::XML(File.open("auto-test/#{dir}/_asserts.xml"))
        .xpath('/asserts/xpath')
        .each do |a|
          Dir.chdir(File.join(temp, "auto-test/#{dir}")) do
            xml = Nokogiri::XML(File.read("#{a['item']}.xml"))
            if xml.xpath(a.text).empty?
              puts xml.to_s
              raise "Can't find #{a.text} in #{a['item']}.xml in #{dir}"
            end
          end
        end
      Dir["rules/#{area}/**/*.xsl"].each do |xsl|
        Dir.chdir(File.join(temp, "auto-test/#{dir}")) do
          xslt = Nokogiri::XSLT(File.read(File.join(home, xsl)))
          xslt.transform(Nokogiri::XML('<e/>')).xpath('//error').each do |e|
            raise e
          end
        end
      end
    end
    print Rainbow('.').green
  end
  puts "\nAll auto-updates are clean\n\n"
end

desc 'Build a site for GitHub Pages'
task :site, [:version] do |_, args|
  raise 'You have to call "rake site[123]"' unless args[:version]
  puts "Building a site for v.#{args[:version]}..."
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  dir = FileUtils.mkdir_p('target/site/pages')[0]
  template = File.read('md/_template.html')
  mds = Dir['md/*.md']
  mds.each do |md|
    file = File.join(dir, File.basename(md).gsub(/\.md$/, '.html'))
    File.write(
      file,
      Mustache.render(
        template,
        body: markdown.render(File.read(md)),
        name: File.basename(md).gsub(/\.md$/, '').capitalize,
        version: args[:version],
        date: Time.new.strftime('%-d-%b-%Y')
      )
    )
    print Rainbow('.').green
  end
  puts "\n#{mds.length} HTML page(s) created in #{dir}\n\n"
  FileUtils.mkdir_p("target/site/#{args[:version]}")
  FileUtils.cp_r('xsd', "target/site/#{args[:version]}")
  puts "XSDs copied to target/site/#{args[:version]}"
  FileUtils.mkdir_p('target/site/latest')
  %w[auto rules xsd xsl].each do |p|
    FileUtils.cp_r(p, 'target/site/latest')
    puts "#{p} copied to target/site/latest"
  end
  FileUtils.cp_r('upgrades', 'target/site/latest')
  Dir['upgrades/**/*.xsl'].map { |f| File.dirname(f) }.uniq.each do |d|
    tdir = File.join('target/site/latest', d)
    FileUtils.mkdir_p(tdir)
    File.write(
      File.join(tdir + '/list'),
      Dir[d + '/*.xsl'].sort.map do |f|
        File.basename(f).gsub(/-.*$/, '') + ' ' + f + "\n"
      end.join('')
    )
  end
  puts 'Upgrades copied to target/site/latest/upgrades'
  Dir['target/site/**/*'].select { |f| File.file?(f) }.each do |f|
    File.write(f, File.read(f).gsub(/SNAPSHOT/, args[:version]))
  end
  puts "Version #{args[:version]} injected into all site files"
  xslt = Nokogiri::XSLT(File.read('misc/index-html.xsl'))
  Dir['target/site/**/*'].reject { |d| File.file?(d) }.each do |d|
    xml = Nokogiri::XML::Builder.new do |x|
      x.index(path: d.gsub('target/site/', '')) do
        Dir.entries(d).reject { |f| f.start_with?('.') }.each do |f|
          x.entry(dir: !File.file?(File.join(d, f))) do
            x.text(f)
          end
        end
      end
    end.doc
    File.write(File.join(d, 'index.xml'), xml.to_s)
    File.write(File.join(d, 'index.html'), xslt.transform(xml))
  end
  puts 'Index files created'
  puts "The site is ready in target/site\n\n"
end

require 'rubocop/rake_task'
desc 'Run RuboCop on all directories'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
  task.requires << 'rubocop-rspec'
end

require 'xcop/rake_task'
desc 'Validate all XML/XSL/XSD/HTML files for formatting'
Xcop::RakeTask.new :xcop do |task|
  task.license = 'LICENSE'
  task.includes = ['**/*.xml', '**/*.xsl', '**/*.xsd', '**/*.html']
  task.excludes = ['target/**/*']
end

desc 'Make sure no files start with an underscore'
task :underscores do
  Dir['**/*.xml', '**/*.xsl', '**/*.xsd'].each do |f|
    next if f =~ %r{^(target|auto-test)/.+}
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
