module Verbalyser
  class VerbSorter
    def initialize(verbs_list)
      @verbs_list = verbs_list
      # print @verbs_list
      # puts "This is the class: #{@verbs_list.class}"
      @lithuanian_alphabet = %w[a ą b c č d e ę ė f g h i į y j k l m n o p q r s š t u ų ū v z ž]
      @output_folder = "data/verbs_by_stem_endings/"
    end

    # def test_folder
    #   output_file = "#{@output_folder}testicles.txt"
    #   puts output_file""
    #   File.open(output_file, "w")
    # end

    def sort_verbs_by_stem_endings

      # puts "#{@verbs_list.class}"
      #
      # @verbs_list.each do |verb|
      #   if verb.strip[-2,2] == "ti"
      #     puts "verb: #{verb}"
      #   end
      # end

      @verbs_list.each do |verb|
        @lithuanian_alphabet.each do |last_letter|
          @lithuanian_alphabet.each do |second_last_letter|
            @lithuanian_alphabet.each do |third_last_letter|
              @lithuanian_alphabet.each do |fourth_last_letter|
                if verb.strip[-2,2] == "ti"
                  # puts "found a verb: #{verb}"
                  if verb[-3] == last_letter
                    # puts "found last letter: #{last_letter}"
                    if verb[-4] == second_last_letter
                      # puts "found second last letter: #{second_last_letter}"
                      if verb[-5] == third_last_letter
                        if verb[-6] == fourth_last_letter
                          puts "found verb and endings: #{verb.strip} - #{fourth_last_letter}#{third_last_letter}#{second_last_letter}#{last_letter}i"
                          writing_file = File.open("#{@output_folder}x_#{third_last_letter}#{second_last_letter}#{last_letter}i_(#{fourth_last_letter})", "a")
                          puts "Writing in this verb: #{verb.strip}"
                          writing_file.write("#{verb.strip}\n")
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end

    end
  end
end

verbs_file = "data/verbs_full_list.txt"

parse_verbs_file = File.readlines(verbs_file)
testing = Verbalyser::VerbSorter.new(parse_verbs_file)
# testing.test_folder
testing.sort_verbs_by_stem_endings
