require 'open-uri'
require 'nokogiri'

module Verbalyser

  class CooljugatorFetcher
    def initialize
      @source_url = "http://cooljugator.com/lt/list/all"
      @output_folder = "output/"
      @raw_html_output_filename = "#{@output_folder}raw_output.html"
      @nokogiri_output_filename = "#{@output_folder}nokogiri_output.txt"
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

    def read_raw_html
      puts "Here is the output\n"
      print File.readlines(@raw_html_output_filename)
    end



  end
end

# testing = Verbalyser::CooljugatorFetcher.new
# testing.read_raw_html
