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

    def identify_whether_verb_is_reflexive(infinitive_verb)

      if infinitive_verb[-2, 2] == "ti"
        @reflexivity = "not_reflexive"
      elsif infinitive_verb[-3, 3] == "tis"
        @reflexivity = "reflexive"
      end

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

    def isolate_lemma_suffix(infinitive_verb)

      find_longest_matching_lemma(infinitive_verb)

      if infinitive_verb[-2, 2] == "ti"
        stripped_standard_infinitive_verb = infinitive_verb[0...-2]
        stem_ending = stripped_standard_infinitive_verb[@matching_lemma.length..-1]

        if stem_ending.length > 0
          @nugget = stem_ending
          puts "#{infinitive_verb} Standard nugget: #{@nugget}"
        else
          @stem = stripped_standard_infinitive_verb
          puts "#{infinitive_verb} stem: #{@stem}"
        end

      elsif infinitive_verb[-3, 3] == "tis"
        stripped_reflexive_infinitive_verb = infinitive_verb[0...-3]
        stem_ending = stripped_reflexive_infinitive_verb[@matching_lemma.length..-1]

        if stem_ending.length > 0
          @nugget = stem_ending
          puts "#{infinitive_verb} Reflexive nugget: #{@nugget}"
        else
          @stem = stripped_reflexive_infinitive_verb
          puts "#{infinitive_verb} Reflexive stem: #{@stem}"
        end

      else
        puts "This might not be an infinitive verb: #{verb}"
      end

      puts "This is the nugget #{@nugget} for #{infinitive_verb}"

    end

    def classify_verb_by_forms(infinitive_verb)

      isolate_lemma_suffix(infinitive_verb)

      puts "infinitive_verb: #{infinitive_verb}"

      if @nugget.length > 0
        puts  "This is the nugget: #{@nugget}"
      end

      @verb_database.each do |line|
        if line.include?(infinitive_verb)

          verb_array = line.strip.split(",")
          puts "first item: #{verb_array[0]}"
          puts "second item: #{verb_array[1]}"
          puts "third item: #{verb_array[2]}"

          @verb_file_name = ""

          verb_array.each do |main_form_verb|
            puts "This is the main form of the verb: #{main_form_verb}"

            stem_extract = main_form_verb[/[aãàáąą̃ą̀ą́eẽeẽèéęę̃ę̀ę́ėė̃ė̀ė́iĩìíį̃į̀įįyỹỳýũùúuųų̃ų̀ų́ūū̃ū̀ū́](.*)/]

            first_vowel_of_stem_extract = main_form_verb[/[aãàáąą̃ą̀ą́eẽeẽèéęę̃ę̀ę́ėė̃ė̀ė́iĩìíį̃į̀įįyỹỳýũùúuųų̃ų̀ų́ūū̃ū̀ū́]/]

            puts "This is the main_form_verb starting from '#{first_vowel_of_stem_extract}': #{stem_extract}"

            if @verb_file_name == ""
              @verb_file_name = stem_extract
            else
              @verb_file_name = @verb_file_name + "_" + stem_extract
            end



            # puts "This is the verb_file_name: #{@verb_file_name}"

          end
          puts "this is the verb file name: #{@verb_file_name}"

          @verb_group_output_filename = @output_folder + @verb_file_name
          verb_group_output_file = File.open(@verb_group_output_filename, "a")
          verb_group_output_file.write(line)
          verb_group_output_file.close

        end
      end

      x = @verb_file_name

    end

    def write_verb_forms_to_group_file(infinitive_verb)
      classify_verb_by_forms(infinitive_verb)

      puts "This is the prospective filename: #{@verb_file_name}"
    end



  end
end
