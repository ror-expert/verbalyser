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

      # folder_tree = Dir.glob("data/curated_verbs/**/*/")
      level_1_folder_tree = Dir.glob("data/curated_verbs/*/")



      level_1_folder_tree.each do |sub_folder|
        if File.directory?(sub_folder)
          puts "#{sub_folder}: directory"
          open_book.write("<h1>#{File.basename(sub_folder)}</h1>\n")

          level_2_folder_tree = Dir.glob("#{sub_folder}*/")
          level_2_folder_tree.each do |sub_sub_folder|
            puts "#{sub_sub_folder}: sub_directory"
            open_book.write("<h2>#{File.basename(sub_folder)}</h2>\n")

          end

        end
      end

      open_book.close
    end
  end
end

testing = Verbalyser::BookBuilder.new
testing.build_book
