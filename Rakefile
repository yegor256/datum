# encoding: utf-8
#
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

task default: [:clean, :xsd, :copyright]

desc 'Validate all XML/XSD files'
task :xsd do
  total = 0
  Dir['xml/**/*.xml'].each do |p|
    xsd = Nokogiri::XML::Schema(
      File.read(p.sub(/xml\//, '').sub(/\/[^\/]+\.xml$/, '.xsd'))
    )
    xml = Nokogiri::XML(File.read(p))
    xsd.validate(xml).each do |error|
      puts "#{p}: #{error.message}"
      total += 1
    end
  end
  raise "#{total} errors" unless total == 0
  puts 'All XML/XSD files are clean'
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
