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
      level_1_files = Dir.glob("data/curated_verbs/*")

      level_1_folder_tree.each do |sub_folder|
        puts "DIRECTORY: #{sub_folder}"
        open_book.write("<h1>#{File.basename(sub_folder)}</h1>\n")

        level_1_files.each do |file_level_1|
          if File.directory?(file_level_1)
            puts "DIRECTORY"
          else
            open_book.write("<p>#{File.basename(file)}</p>\n")
          end
        end

        level_2_folder_tree = Dir.glob("#{sub_folder}*/")
        level_2_files = Dir.glob("#{sub_folder}*")

        level_2_folder_tree.each do |sub_sub_folder|
          open_book.write("<h2>#{File.basename(sub_sub_folder)}</h2>\n")

          level_2_files.each do |sub_file|
            if File.directory?(sub_file)
              puts "DIRECTORY"
            else
              open_book.write("<p>#{File.basename(sub_file)}</p>\n")
            end

            level_3_folder_tree = Dir.glob("#{sub_sub_folder}*/")
            level_3_files = Dir.glob("#{sub_sub_folder}*")

            level_3_folder_tree.each do |sub_sub_sub_folder|
              open_book.write("<h3>#{File.basename(sub_sub_sub_folder)}</h3>\n")

              level_3_files.each do |sub_sub_file|
                if File.directory?(sub_sub_file)
                  puts "DIRECTORY"
                else
                  open_book.write("<p>#{File.basename(sub_sub_file)}</p>\n")
                end
              end
            end
          end
        end
      end

      open_book.close

      end
    end
  end
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


testing = Verbalyser::BookBuilder.new
testing.build_book
