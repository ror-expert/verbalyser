require 'open-uri'
require 'nokogiri'

module Verbalyser
  class LemmaScraper

    SOURCE_URL = 'http://tekstynas.vdu.lt/~irena/morfema_list.php?letter='
    LITHUANIAN_ALPHABET = [
      "a", "b", "c", "č", "d", "e", "ę", "ė", "f", "g", "h", "i", "į", "y", "j", "k", "l", "m", "n", "o", "p", "r", "s", "š", "t", "u", "ų", "ū", "v", "z", "ž"
    ]

    def initialize
      # @input = input.strip
      @raw_html_folder = "data/raw_files/"
      @raw_nokogiri_folder = "data/raw_nokogiri_files/"
      @tidy_nokogiri_folder = "data/nokogiri_tidy/"
      @clean_nokogiri_folder = "data/nokogiri_clean/"
      @clean_lemmas_folder = "data/lemmas_clean/"

      @dump_file = "raw_html_lemmas.txt"
      @nokogiri_dump = "nokogiri_dump_lemmas.txt"
    end

    def fetch_page

      LITHUANIAN_ALPHABET.each do |letter|
        url = "#{SOURCE_URL}#{letter}"
        encoded_url = URI.encode(url)
        document = open(encoded_url)
        content = document.read
        dump_file_for_letter = "#{@raw_html_folder}#{letter}_#{@dump_file}"
        output_raw_html = File.open(dump_file_for_letter, "w")
        output_raw_html.write(content)
        output_raw_html.close()
      end
    end

    def parse_with_nokogiri

      raw_html_list = Dir["#{@raw_html_folder}*"]

      raw_html_list.each do |filename|
        puts filename
        raw_data = File.open(filename, "r")
        parsed_content = Nokogiri::HTML(raw_data)
        puts parsed_content
        nokogiri_name = "#{@raw_nokogiri_folder}#{filename[15]}_nokogiri_data.txt"
        puts nokogiri_name

        nokogiri_file = File.open(nokogiri_name, "w")
        nokogiri_file.write(parsed_content)
        nokogiri_file.close()
      end
    end

    def tidy_lemma_source_files
      output_array = Array.new

      nokogiri_file_list = Dir["#{@raw_nokogiri_folder}*"]

      nokogiri_file_list.each do |filename|
        puts filename
        output_filename = "data/nokogiri_tidy/#{filename[24]}_testing.txt"
        output_file = File.open(output_filename, "w")

        source_file_nokogiri = File.open(filename, "r")
        File.readlines(source_file_nokogiri).each do |line|

          if line.include?("</a>, <a")
            puts "line with a comma"
            line.gsub!("</a>, <a", "\n")
            output_file.write(line.force_encoding("UTF-8"))
          end
        end
      end
    end

    def extract_lemmas

      file_counter = 1
      lemma_counter = 0
      cleaned_lemma_counter = 0
      dirty_lemma_counter = 0


      source_files = Dir["#{@tidy_nokogiri_folder}*"]


      source_files.each do |filename|

        source_file_nokogiri = File.open(filename, "r")

        output_filename = "#{@clean_nokogiri_folder}refined"


        dirty_output_file = File.open("#{output_filename}_dirty_output.txt", "w")
        # output_file_3 = File.open("#{output_filename}_pass_3.txt", "w")


        File.readlines(source_file_nokogiri).each do |line|
          if line.include?("&amp;morfema=")


            # line.sub!(/href\="morfema\_list\.php\?letter\=\D&amp\;morfema\=/, "")
            line.sub!(/href\="morfema\_list\.php\?letter\=\D&amp\;morfema\=(\S*)>/, "")
            puts "line #{lemma_counter}: #{line}"
            lemma_counter += 1

            if line.include?("&amp;morfema=")
              dirty_lemma_counter += 1
              dirty_output_file.write(line)
            else
              cleaned_lemma_counter += 1

              output_file_letter = File.open("#{output_filename}_letter_#{filename[19]}.txt", "w")

              output_file_letter.write(line.force_encoding("utf-8"))
            end
          end
        end

        # puts "file ##{file_counter}: #{filename}"
        # file_counter += 1

        puts "Clean lemmas: #{cleaned_lemma_counter}"
        puts "Dirty lemmas: #{dirty_lemma_counter}"
        puts "#{filename}"

      end
    end

    def build_lemma_database
      lemmas_database_filename = "lemmas_database.txt"
      lemmas_database_file = "#{@clean_lemmas_folder}#{lemmas_database_filename}"
      lemmas_database = File.open(lemmas_database_file, "a")

      source_files = Dir["#{@clean_lemmas_folder}*"]
      line_counter = 0

      source_files.each do |filename|


        lemma_source_file = File.open(filename, "r")

        File.readlines(lemma_source_file).each do |line|
          puts "line #{line_counter}: #{line.strip}"
          line_counter += 1
          lemmas_database.write("#{line.strip}\n")
        end
      end

    end

  end
end

testing = Verbalyser::LemmaScraper.new
# testing.fetch_page
# testing.parse_with_nokogiri
# testing.tidy_lemma_source_files
# testing.extract_lemmas
testing.build_lemma_database

    # line.gsub!(//, "")
    # line.gsub!(//, "")


          # if line.include?("morfema")
          #   line.gsub!(//, "")
          #   if line.include?("morfema")
          #     line.gsub!(//, "")
          #     if line.include?("morfema")
          #       #
          #     else
          #       output_file_2.write(line)
          #     end
          #   else
          #     puts "cleaned?: #{line}"
          #     output_file_1.write(line)
          #   end
          # end


        # File.readlines(source_file_nokogiri).each do |line|
        #   if line.include?("morfema_list.php?")
        #     line.gsub!(//, "")
        #     if line.include?("morfema")
        #       puts "Not cleaned: #{line}"
        #     else
        #       puts "Cleaned? #{line}"
        #       output_file_2.write(line)
        #     end
        #   end
        # end


    # if line.to_s.include?(//)
    #   puts "Found one: #{line}"

    #   source_filename = "#{@tidy_nokogiri_folder}testing.txt"
    #   source_file = File.open(source_filename, "r")
    #   output_filename = "#{@tidy_nokogiri_folder}output.txt"
    #   output_file = File.open(output_filename, "w")
    #
    #   File.readlines(source_file).each do |line|
    #     if line.include?('href="morfema_list.php?letter=')
    #       puts "Got a catch! #{line}"
    #       line.gsub!(//, "")
    #       output_file.write(line)
    #     end
    #   end
    # end
