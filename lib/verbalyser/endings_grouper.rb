require 'remove_accents'

module Verbalyser
  class EndingsGrouper

    def initialize
      @output_folder = "output/grouped/"
      @lemma_database = File.readlines("data/lemmas_database.txt")
      @verb_database = File.readlines("data/verb_shortlist_core_conjugated.txt")
      @input_output = "matching_stem.txt"

      @lithuanian_consonants = %w[b c č d f g h j k l m n p q r s š t v z ž]


      @lithuanian_vowels = %w[a ã à á ą ą̃ ą̀ ą́ e ẽ è é ę ę̃ ę̀ ę́ ė ė̃  ė̀  ė́  i ĩ ì í į̃  į̀ į į y ỹ ỳ ý o õ ò ó ũ ù ú u ų ų̃ ų̀ ų́ ū ū̃  ū̀  ū́]

      @from_first_vowel = /[aãàáąą̃ą̀ą́eẽeẽèéęę̃ę̀ę́ėė̃ė̀ė́iĩìíį̃į̀įįoõòóyỹỳýũùúuųų̃ų̀ų́ūū̃ū̀ū́](.*)/

    end

    def identify_whether_verb_is_reflexive(infinitive_verb)
      if infinitive_verb.strip[-2, 2] == "ti"
        @reflexivity = false
        @stripped_verb = infinitive_verb[0...-2]
      end

      if infinitive_verb.strip[-3, 3] == "tis"
        @reflexivity = true
        @stripped_verb = infinitive_verb[0...-3]
      end

      verb_reflexivity = @reflexivity
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

      if @matching_lemma[-2,2] == "in"
        @nugget = stripped_verb[@matching_lemma[0...-2].length..-1]
        @nugget_in = true
        @lemma_in = false
      elsif stripped_verb[-2,2] == "in"
        @nugget = stripped_verb[@matching_lemma[0...-1].length..-1]
        @nugget_in = false
        @lemma_in = true
      else
        @nugget = stripped_verb[@matching_lemma.length..-1]
      end

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

      puts "infinitive_verb: #{infinitive_verb}"
      puts "stripped_verb: #{@stripped_verb}"
      puts "matching_lemma: #{@matching_lemma}"
      puts "nugget: #{@nugget}"
      puts "nugget_in: #{@nugget_in}"
      puts "nugget_n: #{@nugget_n}"
      puts "lemma_in: #{@lemma_in}"
      puts "lemma_n: #{@lemma_n}"

      @verb_database.each do |line|

        verb_array = line.strip.split(",")
        if verb_array[0].strip == infinitive_verb
          @infinitive_form = verb_array[0].strip
          @present3 = verb_array[1].strip
          @past3 = verb_array[2].strip
          puts "verb_array[0]: #{verb_array[0]}"
          puts "verb_array[1]: #{verb_array[1]}"
          puts "verb_array[2]: #{verb_array[2]}"
        end
      end

      if @matching_lemma.length > 0
        puts "lemma match!"
      end

      @present3_slice = @present3[(@present3.count(@nugget))..-1]
      @past3_slice = @past3[(@past3.count(@nugget))..-1]
      # puts "present3_slice: #{@present3_slice}"
      # puts "past3_slice: #{@past3_slice}"



      if @infinitive_form.match(infinitive_verb)

        if @reflexivity == false && @lemma_suffix_found == true

          part1 = @infinitive_form[-(@nugget.length + "ti".length), (@nugget.length + "ti".length)]

          if @nugget_in == true
            part2 = @present3[@matching_lemma[0...-2].length..-1]

          else
            part2 = @present3[@matching_lemma.length..-1]
            #
          end

          if @nugget_in == true
            part3 = @past3[@matching_lemma[0...-2].length..-1]
          else
            part3 = @past3[@matching_lemma.length..-1]
          end

          @file_name = "#{part1}_#{part2}_#{part3}".removeaccents

        elsif @reflexivity == true && @lemma_suffix_found == true

          part1 = @infinitive_form[-(@nugget.length + "tis".length), (@nugget.length + "tis".length)]

          if @nugget_in == true
            part2 = @present3[@matching_lemma[0...-2].length..-1]
          else
            part2 = @present3[@matching_lemma.length..-1]
          end

          if @nugget_in == true
            part3 = @past3[@matching_lemma[0...-2].length..-1]
          else
            part3 = @past3[@matching_lemma.length..-1]
          end

          @file_name = "#{part1}_#{part2}_#{part3}".removeaccents

        elsif @reflexivity == false && @lemma_suffix_found == false

          part1 = @infinitive_form[@from_first_vowel]
          part2 = @present3[@from_first_vowel]
          part3 = @past3[@from_first_vowel]

          @file_name = "#{part1}_#{part2}_#{part3}".removeaccents

        elsif @reflexivity == true && @lemma_suffix_found == false

          part1 = @infinitive_form[@from_first_vowel]
          part2 = @present3[@from_first_vowel]
          part3 = @past3[@from_first_vowel]

          @file_name = "#{part1}_#{part2}_#{part3}".removeaccents

        else
        end
      end

      puts "\n**************************************\n\n"

      file_name = @file_name
      x = file_name

    end

    def write_verb_forms_to_group_file(infinitive_verb)
      create_classificatory_file_name(infinitive_verb)

      output_verb_sequence = "#{@infinitive_form}, #{@present3}, #{@past3}\n"
      testing_output_verb_sequence = "[#{output_verb_sequence}]"
      file_path = @output_folder + @file_name + ".txt"



      if File.exist?(file_path) == false

         "No file for this pattern, creating a new one..."

        output_file = File.open(file_path, "w")
        output_file.write(output_verb_sequence)
        output_file.close

      elsif File.exists?(file_path) == true

        open_existing_file = File.open(file_path, "a+")
        inspection_file = File.readlines(open_existing_file)

        inspection_file.map do |line|

          item = line.split(",")
          @test_for_duplicate = item[0].match?(@infinitive_form)
        end

        if @test_for_duplicate == true
        else
          open_existing_file.write(output_verb_sequence)
          open_existing_file.close
        end
      end

      file_review = File.readlines(file_path)
      if file_review.include?(output_verb_sequence)
        @inspection_results = output_verb_sequence.split(", ")
      end

      file_check = @inspection_results

    end
  end
end
