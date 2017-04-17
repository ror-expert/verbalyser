module Verbalyser
  class EndingsGrouper

    def initialize
      @output_folder = "output/grouped/"
      @lemma_database = File.readlines("data/lemmas_database.txt")
      @verb_database = File.readlines("data/verb_shortlist_core_conjugated.txt")
      @input_output = "matching_stem.txt"

      @lithuanian_consonants = %w[b c č d f g h j k l m n p q r s š t v z ž]

      # @lithuanian_vowels = %w[a ą e ę ė ẽ i į y o u ų ū]

      @lithuanian_vowels = %w[a ã à á ą ą̃ ą̀ ą́ e ẽ è é ę ę̃ ę̀ ę́ ė ė̃  ė̀  ė́  i ĩ ì í į̃  į̀ į į y ỹ ỳ ý o õ ò ó ũ ù ú u ų ų̃ ų̀ ų́ ū ū̃  ū̀  ū́]

      @from_first_vowel = /[aãàáąą̃ą̀ą́eẽeẽèéęę̃ę̀ę́ėė̃ė̀ė́iĩìíį̃į̀įįyỹỳýũùúuųų̃ų̀ų́ūū̃ū̀ū́](.*)/

      def identify_whether_verb_is_reflexive(infinitive_verb)
        if infinitive_verb[-2, 2] == "ti"
          @reflexivity = false
          @stripped_verb = infinitive_verb[0...-2]
        elsif infinitive_verb[-3, 3] == "tis"
          @reflexivity = true
          @stripped_verb = infinitive_verb[0...-3]
        end

        verb_reflexivity = @reflexivity
      end
    end

    def check_for_lemma_suffix(stripped_verb)

      matching_stem_array = Array.new
      stems = (0..stripped_verb.size - 1).each_with_object([]) { |i, subs| subs << stripped_verb[0..i] }

      stems.each do |stem|
        @lemma_database.each do |lemma|
          if lemma[0] == stem[0] && lemma.strip == stem.strip
            matching_stem_array.push(stem.strip)
          end
        end
      end

      @matching_lemma = matching_stem_array.max
      @nugget = stripped_verb[@matching_lemma.length..-1]

      if @nugget.length > 0
        nugget_found = true
      elsif @nugget.length == 0
        nugget_found = false
      end

      @lemma_suffix_found = nugget_found
    end

    def create_classificatory_file_name(infinitive_verb)
      identify_whether_verb_is_reflexive(infinitive_verb)
      check_for_lemma_suffix(@stripped_verb)

      @verb_file_name = ""

      @verb_database.each do |line|

        if line.include?(infinitive_verb)

          verb_array = line.strip.split(",")

          @infinitive_form = verb_array[0].strip
          @present3 = verb_array[1].strip
          @past3 = verb_array[2].strip


          if @reflexivity == false && @lemma_suffix_found == true

            part1 = @infinitive_form[-(@nugget.length + "ti".length), (@nugget.length + "ti".length)]
            part2 = @present3[@matching_lemma.length..-1]
            part3 = @past3[@matching_lemma.length..-1]

            @file_name = "#{part1}_#{part2}_#{part3}"

          elsif @reflexivity == true && @lemma_suffix_found == true

            part1 = @infinitive_form[-(@nugget.length + "tis".length), (@nugget.length + "tis".length)]
            part2 = @present3[@matching_lemma.length..-1]
            part3 = @past3[@matching_lemma.length..-1]

            @file_name = "#{part1}_#{part2}_#{part3}"

          elsif @reflexivity == false && @lemma_suffix_found == false

            part1 = @infinitive_form[@from_first_vowel]
            part2 = @present3[@from_first_vowel]
            part3 = @past3[@from_first_vowel]

            @file_name = "#{part1}_#{part2}_#{part3}"

          elsif @reflexivity == true && @lemma_suffix_found == false

            part1 = @infinitive_form[@from_first_vowel]
            part2 = @present3[@from_first_vowel]
            part3 = @past3[@from_first_vowel]

            @file_name = "#{part1}_#{part2}_#{part3}"

          end
        end
      end

      file_name = @file_name

    end

    def write_verb_forms_to_group_file(infinitive_verb)
      create_classificatory_file_name(infinitive_verb)

      output_verb_sequence = "#{@infinitive_form}, #{@present3}, #{@past3}\n"
      file_path = @output_folder + @file_name + ".txt"

      # puts "The file name received is #{@file_name}"
      # puts "The file to be created is: #{file_path}"
      #
      # puts "does the file #{file_path} exist? #{File.exists?(file_path)}"

      if File.exist?(file_path) == false

        output_file = File.open(file_path, "a+")
        output_file.write(output_verb_sequence)
        output_file.close

      elsif File.exists?(file_path) == true

        inspection_file = File.open(file_path, "r")
        check_for_duplicates = File.readlines(inspection_file)

        puts "check_for_duplicates: #{check_for_duplicates}"

        check_for_duplicates.each do |line|
          if line == output_verb_sequence
            puts "This line exists already: #{line}"
            inspection_file.close
            @inspection_results = output_verb_sequence.split(" ,")
          end
        end
      end

      file_check = @inspection_results

    end
  end
end
