require 'open-uri'
require 'nokogiri'

module Verbalyser
  class LemmaScraper

  end
end

class CooljugatorScraper
  SOURCE_URL = 'http://cooljugator.com/lt/'
  OUTPUT_FOLDER = "output/"

  def initialize(input)
    @input = input.strip
    @dump_file = "raw_html.txt"
    @nokogiri_dump = "nokogiri_dump.txt"
  end

  def fetch_page
    url = "#{SOURCE_URL}#{@input}"
    encoded_url = URI.encode(url)
    puts "This is the URL: #{encoded_url}"
    document = open(encoded_url)
    content = document.read
    # puts content
    output_raw_html = File.open(@dump_file, "w")
    output_raw_html.write(content)
    output_raw_html.close()
  end

  def parse_with_nokogiri
    raw_data = File.open(@dump_file, "r")
    parsed_content = Nokogiri::HTML(raw_data)
    nokogiri_file = File.open(@nokogiri_dump, "w")
    nokogiri_file.write(parsed_content)
    nokogiri_file.close()
  end

  def locate_third_person

    output_array = Array.new

    source_file_nokogiri = File.open(@nokogiri_dump, "r")

    output_array.push(@input)

    File.readlines(source_file_nokogiri).each do |line|
      if line.include?('id="present3"')
        nugget = line
        jewel_present = nugget.scan( /data-stressed=\"(.*)\">/ )
        # puts jewel_present
        output_array.push(jewel_present[0][0])
      end
      if line.include?('id="past3"')
        nugget = line
        jewel_past = nugget.scan( /data-stressed=\"(.*)\">/ )
        output_array.push(jewel_past[0][0])
      end
    end

    puts "This is the output array: #{output_array}"

    output_filename = "#{OUTPUT_FOLDER}#{output_array[0]}"
    output_file = File.open(output_filename, "a")
    output_array.each do |item|
      if item == output_array[-1]
        output_file.write("#{item}\n")
      else
        output_file.write("#{item}, ")
      end
    end

    output_file.close()

  end
end
