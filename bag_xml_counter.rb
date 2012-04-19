#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'zip/zip'
require 'rexml/document'
include REXML

def report(filename, paths)
  puts filename
  xml = ''
  File.open(filename, 'r') do |f|
    xml = f.read
  end
  doc = Document.new(xml)
  paths.each_pair do |key, path|
    {
      de: 'DescriptionDe',
      fr: 'DescriptionFr'
    }.each_pair do |lang, lang_path|
      count = 0
      doc.elements.each(path + "/" + lang_path) do |element|
       count += 1 if element.get_text.to_s.chomp.length > 0
      end
      puts "#{key} [#{lang}]: #{count}"
    end
  end
end

zip = 'XMLPublications-2012.04.02.zip'
if ARGV.first != zip or
   !File.exist?(zip)
  exit
end
Zip::ZipFile.foreach(zip) do |entry|
  case entry.name
  when 'Preparations.xml'
    paths = {
      preparations: 'Preparations/Preparation/Limitations/Limitation',
      packs:        'Preparations/Preparation/Packs/Pack/Limitations/Limitation',
      itcodes:      'Preparations/Preparation/ItCodes/ItCode/Limitations/Limitation',
    }
    report 'Preparations.xml', paths
  when 'ItCodes.xml'
    #paths = {
    #  itcode: 'ItCodes/ItCode/Limitations/Limitation',
    #}
    #report 'Preparations.xml', paths
  end
end

=begin
File.open('ItCodes.xml', 'r') do |f|
  xml = f.read 
end
doc = Document.new(xml)

paths = {
  de: 'ItCodes/ItCode/Limitations/Limitation/DescriptionDe',
  fr: 'ItCodes/ItCode/Limitations/Limitation/DescriptionFr'
}
paths.each_pair do |lang, path|
  count = 0
  doc.elements.each(path) do |element|
   count += 1 if element.get_text.to_s.chomp.length > 0
  end
  p "#{lang}: #{count}"
end
=end

=begin
File.open('Preparations.xml', 'r') do |f|
  xml = f.read 
end
doc = Document.new(xml)

paths = {
  preparations: 'Preparations/Preparation/Limitations/Limitation',
  packs:        'Preparations/Preparation/Packs/Pack/Limitations/Limitation',
  itcodes:      'Preparations/Preparation/ItCodes/ItCode/Limitations/Limitation',
}
paths.each_pair do |key, path|
  {
    de: 'DescriptionDe',
    fr: 'DescriptionFr'
  }.each_pair do |lang, lang_path|
    count = 0
    doc.elements.each(path + "/" + lang_path) do |element|
     count += 1 if element.get_text.to_s.chomp.length > 0
    end
    p "#{key} [#{lang}]: #{count}"
  end
end
=end
