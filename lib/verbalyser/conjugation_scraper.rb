require 'open-uri'
require 'nokogiri'

module Verbalyser
  class ConjugationScraper

    SOURCE_URL = 'http://cooljugator.com/lt/'

    def initialize(verb_list)
      @verb_list = verb_list

      @output_folder = "output/"
      @output_filename = "verb_shortlist_core_conjugated.txt"
      @output_array = Array.new

      @processing_folder = "output/processing/"

      @output_folder_grouped = "output/grouped/"

    end

    def fetch_conjugations

      # verb_list = File.readlines(@verb_list)
      # puts

      output_file = File.open("#{@output_folder}#{@output_filename}", "w")

      @verb_list.each do |verb|
        verb = verb.strip

        url = "#{SOURCE_URL}#{verb}"
        encoded_url = URI.encode(url)
        puts "This is the URL: #{encoded_url}"

        document = open(encoded_url)
        content = document.read
        nokogiri_parsed_content = Nokogiri::HTML(content)
        output_nokogiri = File.open("#{@processing_folder}#{verb}", "w")
        output_nokogiri.write(nokogiri_parsed_content)
        output_nokogiri.close()

        File.readlines(output_nokogiri).each do |line|
          if line.include?('id="present3"')
            present3 = line.scan( /data-stressed=\"(.*)\">/ )
            @present3_stripped = present3[0][0]
          end
          if line.include?('id="past3"')
            past3 = line.scan( /data-stressed=\"(.*)\">/ )
            @past3_stripped = past3[0][0]
          end
        end


        # @output_array.push("#{verb}, #{@present3_stripped}, #{@past3_stripped}\n")

        verb_set = "#{verb}, #{@present3_stripped}, #{@past3_stripped}\n"

        output_file = File.open("#{@output_folder}#{@output_filename}", "a")
        output_file.write(verb_set)
        output_file.close

        # @output_array.each do |line|
        #   output_file.write(line)
        # end
        #
        # output_file.close

      end



      conjugated_verbs = File.readlines("#{@output_folder}#{@output_filename}")

    end
  end
end

verb_list = File.readlines("output/verb_shortlist_core.txt")
testing = Verbalyser::ConjugationScraper.new(verb_list)
testing.fetch_conjugations
