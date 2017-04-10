require 'open-uri'
require 'nokogiri'

module Verbalyser

  class CooljugatorFetcher
    def initialize
      @source_url = "http://cooljugator.com/lt/list/all"
      @output_folder = "output"
      @raw_html_output_filename = "#{@output_folder}/raw_html_output.html"

      @nokogiri_text_extract_raw_filename = "#{@output_folder}/nokogiri_text_extract_raw.txt"

      @nokogiri_text_extract_first_clean = "#{@output_folder}/nokogiri_text_extract_first_clean.txt"

      @verb_list_cleaned = "#{@output_folder}/verb_list_cleaned.txt"

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
      output_nokogiri = File.open(@nokogiri_text_extract_raw_filename, "w")
      output_nokogiri.write(parsed_content)

      parsed_content_file = File.readlines(@nokogiri_text_extract_raw_filename)

    end

    def nokogiri_extract_raw_text
      raw_data = File.open(@raw_html_output_filename, "r")
      parsed_content = Nokogiri::HTML.parse(raw_data)
      text_extract_document = File.open(@nokogiri_text_extract_first_clean, "w")

      content_css = parsed_content.css("li")

      content_css.each do |line|
        text_extract_document.write("#{line.text}\n")
      end

      text_extract_document.close()

      nokogiri_text_extract_first_clean = File.readlines(text_extract_document)

    end

    def clean_verb_list
      raw_data = File.readlines(File.open(@nokogiri_text_extract_first_clean, "r"))
      cleaned_verbs_list = File.open(@verb_list_cleaned, "w")

      raw_data.each do |line|
        if line.include?(" - ")
          clean_line = "#{line[/(.*)-/,1].strip}\n"
          cleaned_verbs_list.write(clean_line)
        end
      end

      cleaned_verbs_list.close

      review_cleaned_verb_list = File.readlines(cleaned_verbs_list)
    end

  end
end

# testing = Verbalyser::CooljugatorFetcher.new
# testing.clean_verb_list
