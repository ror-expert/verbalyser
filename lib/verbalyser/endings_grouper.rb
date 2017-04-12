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

    end

    def find_longest_matching_lemma(verb)

      matching_stem_array = Array.new

      stems = (0..verb.size - 1).each_with_object([]) { |i, subs| subs << verb[0..i] }

      stems.each do |stem|
        @lemma_database.each do |lemma|
          if lemma[0] == stem[0] && lemma.strip == stem.strip
            matching_stem_array.push(stem.strip)
          end
        end
      end

      @matching_lemma = matching_stem_array.max

    end

    def isolate_lemma_suffix(verb)

      find_longest_matching_lemma(verb)

      # puts "This is the matching lemma from before: #{@matching_lemma}"

      if verb[-2, 2] == "ti"
        stripped_standard_verb = verb[0...-2]
        stem_ending = stripped_standard_verb[@matching_lemma.length..-1]

        if stem_ending.length > 0
          isolated_stem_ending = stem_ending
        else
          isolated_stem_ending = stripped_standard_verb
        end

      elsif verb[-3, 3] == "tis"
        stripped_reflexive_verb = verb[0...-3]
        stem_ending = stripped_reflexive_verb[@matching_lemma.length..-1]

        if stem_ending.length > 0
          isolated_stem_ending = stem_ending
        else
          isolated_stem_ending = stripped_reflexive_verb
        end

      else
        # "This might not be an infinitive verb: #{verb}"
      end

      # puts "This is the isolated_stem_ending #{isolated_stem_ending}"
      nugget = isolated_stem_ending
    end

    def classify_verb_by_forms(infinitive_verb)

      puts "infinitive_verb: #{infinitive_verb}"

      @verb_database.each do |line|
        if line.include?(infinitive_verb)
          puts "These are the forms: #{line}"
          puts "This is the stripped line: #{line.strip}"
          verb_array = line.strip.split(",")
          print verb_array
          puts ""

          verb_array.each do |main_form_verb|

            exploded_letters = main_form_verb.split("")
            puts "Exploded letters: #{exploded_letters}"

            puts main_form_verb[/[aãàáąą̃ą̀ą́eẽèéęę̃ę̀ę́ėė̃ė̀ė́iĩìíį̃į̀įįyỹỳýoõòóũùúuųų̃ų̀ų́ūū̃ū̀ū́]/]



            # puts main_form_verb[/<non_vowel>/]

            # a[/(?<vowel>[aeiou])(?<non_vowel>[^aeiou])/, "non_vowel"] #=> "l"
            # a[/(?<vowel>[aeiou])(?<non_vowel>[^aeiou])/, "vowel"]     #=> "e"



            # exploded_letters.each do |first_letter|
            #   exploded_letters.each do |second_letter|
            #     exploded_letters.each do |third_letter|
            #       exploded_letters.each do |fourth_letter|
            #
            #       end
            #     end
            #   end
            # end

            # exploded_letters.each do |letter|
            #   @lithuanian_vowels.any?.first { |vowel| puts  "found the first vowel of #{main_form_verb}: #{vowel}" }
            # end

            # @lithuanian_vowels.any? { |letter| puts "found it #{main_form_verb[letter]}" }



            # first_vowel = true
            # while first_vowel == true
            #   exploded_letters.each do |letter|
            #     if @lithuanian_vowels.include?(letter)
            #       puts "This is the first_vowel: #{letter}"
            #       first_vowel = false
            #     end
            #   end
            # end

          end
        end
      end
    end
  end
end

            # This will iterate through all the elements:
            #
            # array = [1, 2, 3, 4, 5, 6]
            # array.each { |x| puts x }
            # Prints:
            #
            # This will iterate through all the elements giving you the value and the index:
            #
            # array = ["A", "B", "C"]
            # array.each_with_index {|val, index| puts "#{val} => #{index}" }
            # Prints:
            #
            # A => 0
            # B => 1
            # C => 2




          #
          # verb_array.each do |main_form_verb|
          #   if @lithuanian_consonants.include?(main_form_verb[0])
          #
          #     puts "#{main_form_verb} begins with a consonant"
          #
          #     if @lithuanian_consonants.include?(main_form_verb[])
          #
          #     end
          #
          #   end
