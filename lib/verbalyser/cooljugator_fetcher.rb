require 'open-uri'
require 'nokogiri'

module Verbalyser

  class CooljugatorFetcher
    def initialize
      @source_url = "http://cooljugator.com/lt/list/all"
      @output_folder = "output/"
      @raw_html_output_filename = "#{@output_folder}raw_output.html"
      @nokogiri_output_filename = "#{@output_folder}nokogiri_output.txt"
      @nokogiri_text_extract_full_raw = "#{@output_folder}nokogiri_text_extract_full_raw.txt"
    end

    def fetch_raw_html
      url = @source_url
      encoded_url = URI.encode(url)
      document = open(encoded_url)
      content = document.read
      output_raw_html = File.open(@raw_html_output_filename, "w")
      output_raw_html.write(content)
      output_raw_html.close

      raw_html_completion = File.readlines(File.open(@raw_html_output_filename))
    end

    def parse_raw_html_with_nokogiri
      raw_data = File.open(@raw_html_output_filename, "r")
      parsed_content = Nokogiri::HTML.parse(raw_data)
      output_nokogiri = File.open(@nokogiri_output_filename, "w")
      output_nokogiri.write(parsed_content)

      parsed_content_file = File.readlines(@nokogiri_output_filename)

      # nokogiri_parsed_content = Fil@nokogiri_output_filename
      #
      # demo_parsed_content = File.readlines(File.open("spec/fixtures/demo_nokogiri_content.txt", "r"))

      # puts refined_content

      # ng_parsed = File.open("spec/fixtures/demo_nokogiri_content_parsed.txt", "w")

      # line_items = parsed_content.css("li")
      #
      # line_items.each do |line|
      #   puts line.text
      #   ng_parsed.write("#{line.text}\n")
      # end



    end

    def nokogiri_extract_raw_text

      nokogiri_extract_raw_text_demo = File.readlines(File.open("spec/fixtures/demo_nokogiri_text_extract_raw.txt"))
    end

  end
end

# testing = Verbalyser::CooljugatorFetcher.new
# testing.read_raw_html
