#!/usr/bin/env ruby
# encoding: utf-8

require 'zip/zip'
require 'rexml/document'
include REXML

def report(name, io, paths)
  puts name
  doc = Document.new(io.read)
  paths.each_pair do |key, node|
    {
      de: 'DescriptionDe',
      fr: 'DescriptionFr'
    }.each_pair do |lang, lang_node|
      count = 0
      doc.elements.each(node + "/" + lang_node) do |element|
       count += 1 if element.get_text.to_s.chomp.length > 0
      end
      puts "  #{key} [#{lang}]: #{count}"
    end
  end
end

unless zip = ARGV.first
  zip = './XMLPublications.zip'
end
if !File.exist?(zip)
  puts "#{zip} file not exist."
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
    entry.get_input_stream do |io|
      report entry.name, io, paths
    end
  when 'ItCodes.xml'
    paths = {
      itcodes: 'ItCodes/ItCode/Limitations/Limitation',
    }
    entry.get_input_stream do |io|
      report entry.name, io, paths
    end
  end
end
