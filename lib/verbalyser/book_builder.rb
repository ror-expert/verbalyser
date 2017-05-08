require 'fileutils'
require 'time'
require 'pry'
require 'csv'

module Verbalyser
  class BookBuilder
    def initialize
      @source_folder = "data/curated_verbs/"
      @output_folder = "data/book/"
      @now = Time.now
      puts @new_folder
      @book_hash = Hash.new
      @book_file = @output_folder + "veiksmažodžių_knyga_#{@now.strftime("%Y-%m-%d_%H:%M:%S")}.html"
      @verb_source_data_translations =  "output/nokogiri_text_extract_first_clean.txt"

    end

    def build_book
      @open_translations = File.readlines(@verb_source_data_translations)
      # FileUtils::mkdir_p @new_folder
      open_book = File.open(@book_file, "a+")

      boiler_plate = <<~TEXT
      <!DOCTYPE html>
      <html>
      <head>
      <body>
      <style>
      table, th, td {
        border: 1px solid black;
        border-collapse: collapse;
        text-align:center;
        width:100%;
      }
      </style>
      TEXT

      open_book.write(boiler_plate)

      level_1_folder_tree = Dir.glob("data/curated_verbs/**/*").sort

      level_1_folder_tree.each do |item|
        if File.directory?(item)
          puts "FOLDER: #{item}"
          open_book.write("<h2>#{File.basename(item)}</h2>\n")
          # binding.pry

        elsif item.match(/.*txt/)
          puts "FILE: #{item}"
          new_file_name = File.basename(item)[0...-4]
          open_book.write("<h3>#{new_file_name}</h3>\n")

          @table_header = "
          <br>
          <table style='width:100%'>
          <tr>
          <th>bendratis</th>
          <th>esamasis(3)</th>
          <th>butasis kartinis(3)</th>
          <th>angliškai</th>
          </tr>
          "
          open_book.write(@table_header)

          File.open(item).each do |line|

            verbs = line.split(",")

            infinitive_form = verbs[0]
            present3_form = verbs[1]
            past3_form = verbs[2]

            open_book.write("""
            <tr>
            <td>#{verbs[0]}</td>
            <td>#{verbs[1]}</td>
            <td>#{verbs[2]}</td>
            <td>#{@english_translation}</td>
            </tr>
            """)
            # binding.pry
          end

          open_book.write("</table>")

          # @open_translations.each do |verb_line|
        end
      end

      open_book.close
    end
  end
end

testing = Verbalyser::BookBuilder.new
testing.build_book



#
#
#               if infinitive_form == verb_line.strip.split(",")
#                 puts "found match: #{infinitive_form} and #{verb_line.strip.split(",")}"
#               end
#
#               open_book.write("</table>")
#             end
#           end
#
#           open_book.close
#         end
#       end
#     end
#   end
# end
#
#
#
#             # binding.pry
#
#
#
#             #
#             #   split_extraction = verb_line.strip.split(",")
#             #
#             #   # split_extraction = verb_line.split("\n")[1].split(",")
#             #   english_translation = split_extraction[1]
#             #   @matching_form = split_extraction[0]
#             #   puts "infinitive_form: #{@matching_form}"
#             #   puts "english_translation: #{@english_translation}"
#             #
#             #   if @matching_form == infinitive_form
#             #     puts "matching infinitive_form: #{infinitive_form}"
#             #     puts "matching @english_translation: #{@english_translation}"
#             #   end
#             # end
#
#           # end
#
