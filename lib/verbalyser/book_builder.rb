require 'fileutils'
require 'time'

module Verbalyser
  class BookBuilder
    def initialize
      @source_folder = "data/curated_verbs/"
      @output_folder = "data/book/"
      @now = Time.now
      puts @new_folder
      @book_hash = Hash.new
      @book_file = @output_folder + "veiksmažodžių_knyga_#{@now.strftime("%Y-%m-%d_%H:%M:%S")}.html"
    end

    def build_book
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

        elsif item.match(/.*txt/)

          @temp_array = Array.new

          puts "FILE: #{item}"
          new_file_name = File.basename(item)[0...-4]
          open_book.write("<h3>#{new_file_name}</h3>\n")

          @table_header = "
          <table style='width:100%'>
          <tr>
          <th>bendratis</th>
          <th>esamasis(3)</th>
          <th>butasis kartinis(3)</th>
          </tr>
          "
          open_book.write(@table_header)


          File.open(item).each do |line|

            verbs = line.split(",")
            open_book.write("""
            <tr>
            <td>#{verbs[0]}</td>
            <td>#{verbs[1]}</td>
            <td>#{verbs[2]}</td>
            </tr>
            """)
          end

          open_book.write("</table>")
        end
      end

      open_book.close

    end
  end
end


testing = Verbalyser::BookBuilder.new
testing.build_book

# open_text_file = File.open(item, "r")

# # folder_tree = Dir.glob("data/curated_verbs/**/*/")
# level_1_folder_tree = Dir.glob("data/curated_verbs/*/")
# level_1_files = Dir.glob("data/curated_verbs/*")
#
# level_1_folder_tree.each do |sub_folder|
#   puts "DIRECTORY: #{sub_folder}"
#   open_book.write("<h1>#{File.basename(sub_folder)}</h1>\n")
#
#   level_1_files.each do |file_level_1|
#     if File.directory?(file_level_1)
#       puts "file_level_1: #{file_level_1}"
#     else
#       open_book.write("<h2>#{File.basename(file)}</h2>\n")
#     end
#   end
#
#   level_2_folder_tree = Dir.glob("#{sub_folder}*/")
#   level_2_files = Dir.glob("#{sub_folder}*")
#
#   level_2_folder_tree.each do |sub_sub_folder|
#     open_book.write("<h2>#{File.basename(sub_sub_folder)}</h2>\n")
#
#     level_2_files.each do |sub_file|
#       if File.directory?(sub_file)
#         puts "file_level_2: #{sub_file}"
#       else
#         open_book.write("<h3>#{File.basename(sub_file)}</h3>\n")
#       end
#
#       level_3_folder_tree = Dir.glob("#{sub_sub_folder}*/")
#       level_3_files = Dir.glob("#{sub_sub_folder}*")
#
#       level_3_folder_tree.each do |sub_sub_sub_folder|
#         open_book.write("<h3>#{File.basename(sub_sub_sub_folder)}</h3>\n")
#
#         level_3_files.each do |sub_sub_file|
#           if File.directory?(sub_sub_file)
#             puts "file_level_3: #{sub_sub_file}"
#           else
#             open_book.write("<h4>#{File.basename(sub_sub_file)}</h4>\n")
#           end
#         end
#       end
#     end
#   end
# end
# level_3_folder_tree = Dir.glob("#{sub_folder}*/")
# level_3_folder_tree.each do |sub_sub_sub_folder|
#   puts "#{sub_sub_sub_folder}: sub_directory"
#   open_book.write("<h3>#{File.basename(sub_sub_folder)}</h3>\n")
#
#   level_4_folder_tree = Dir.glob("#{sub_folder}*/")
#   level_4_folder_tree.each do |sub_sub_sub_sub_folder|
#     puts "#{sub_sub_sub_sub_folder}: sub_directory"
#     open_book.write("<h4>#{File.basename(sub_sub_folder)}</h4>\n")
#   end
# end
# end
