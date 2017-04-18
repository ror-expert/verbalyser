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

      @from_first_vowel = /[aãàáąą̃ą̀ą́eẽeẽèéęę̃ę̀ę́ėė̃ė̀ė́iĩìíį̃į̀įįyỹỳýũùúuųų̃ų̀ų́ūū̃ū̀ū́](.*)/

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

      puts "This is the infinitive_verb from the outset: #{infinitive_verb}"
      puts "This is the stripped_verb from the outset: #{@stripped_verb}"
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

      puts "This is the stripped_verb: #{stripped_verb}"
      puts "This is the matching_lemma: #{@matching_lemma}"
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

      @verb_file_name = ""

      @verb_database.each do |line|
        # It's finding bandyti instead of adyti

        verb_array = line.strip.split(",")
        if verb_array[0].strip == infinitive_verb
          @infinitive_form = verb_array[0].strip
          @present3 = verb_array[1].strip
          @past3 = verb_array[2].strip
          puts "verb_array[0]: #{verb_array[0]}"
        end
      end

      if @infinitive_form.match(infinitive_verb)



        if @reflexivity == false && @lemma_suffix_found == true

          part1 = @infinitive_form[-(@nugget.length + "ti".length), (@nugget.length + "ti".length)]
          #puts "This is part1 of #{@infinitive_form}: #{part1}"

          if @nugget_in == true
            part2 = @present3[@matching_lemma[0...-2].length..-1]
            puts "nugget true"
          elsif @lemma_in == true
            part2 = @present3[@stripped_verb[0...-2].length..-1]
            puts "lemma true"
          else
            part2 = @present3[@matching_lemma.length..-1]
            puts "neither true"
          end

          if @nugget_in == true
            part3 = @past3[@matching_lemma[0...-2].length..-1]
            puts "nugget true"
          elsif @lemma_in == true
            part3 = @past3[@stripped_verb[0...2].length..-1]
            puts "lemma true"
          else
            part3 = @past3[@matching_lemma.length..-1]
            puts "neither true"
          end

          @file_name = "#{part1}_#{part2}_#{part3}"
          puts "infinitive_verb: #{infinitive_verb}"
          puts "@infinitive_form: #{@infinitive_form}"
          puts "RFLT #{@infinitive_form}:#{@file_name}"

        elsif @reflexivity == true && @lemma_suffix_found == true

          part1 = @infinitive_form[-(@nugget.length + "tis".length), (@nugget.length + "tis".length)]

          if @nugget_in == true
            part2 = @present3[@matching_lemma[0...-2].length..-1]
          else
            part2 = @present3[@matching_lemma.length..-1]
            #puts "This is part2 Ref: #{part2}"
          end

          if @nugget_in == true
            part3 = @past3[@matching_lemma[0...-2].length..-1]
          else
            part3 = @past3[@matching_lemma.length..-1]
            #puts "This is part3 Ref: #{part3}"
          end

          @file_name = "#{part1}_#{part2}_#{part3}"
          puts "RTLT #{@infinitive_form}:#{@file_name}"

        elsif @reflexivity == false && @lemma_suffix_found == false

          part1 = @infinitive_form[@from_first_vowel]
          part2 = @present3[@from_first_vowel]
          part3 = @past3[@from_first_vowel]

          @file_name = "#{part1}_#{part2}_#{part3}"
          puts "RFLF #{@infinitive_form}:#{@file_name}"

        elsif @reflexivity == true && @lemma_suffix_found == false

          part1 = @infinitive_form[@from_first_vowel]
          part2 = @present3[@from_first_vowel]
          part3 = @past3[@from_first_vowel]

          @file_name = "#{part1}_#{part2}_#{part3}"
          puts "RTLF #{@infinitive_form}:#{@file_name}"

        else
          puts "Something has gone wrong"
        end
      end

      #Something is happening that makes it find a false positive
      # @verb_database.each do |line|
      #
      #   if line.include?("#{infinitive_verb},")
      #
      #     verb_array = line.strip.split(",")
      #
      #     @infinitive_form = verb_array[0].strip
      #     @present3 = verb_array[1].strip
      #     @past3 = verb_array[2].strip
      #
      #     if @infinitive_form.match(infinitive_verb)
      #
      #       if @reflexivity == false && @lemma_suffix_found == true
      #
      #         part1 = @infinitive_form[-(@nugget.length + "ti".length), (@nugget.length + "ti".length)]
      #         #puts "This is part1 of #{@infinitive_form}: #{part1}"
      #
      #         if @nugget_in == true
      #           part2 = @present3[@matching_lemma[0...-2].length..-1]
      #         else
      #           part2 = @present3[@matching_lemma.length..-1]
      #         end
      #
      #         if @nugget_in == true
      #           part3 = @past3[@matching_lemma[0...-2].length..-1]
      #         else
      #           part3 = @past3[@matching_lemma.length..-1]
      #           #puts "This is part3 NR: #{part3}"
      #         end
      #
      #         @file_name = "#{part1}_#{part2}_#{part3}"
      #         puts "RFLT #{@infinitive_form}:#{@file_name}"
      #
      #       elsif @reflexivity == true && @lemma_suffix_found == true
      #
      #         part1 = @infinitive_form[-(@nugget.length + "tis".length), (@nugget.length + "tis".length)]
      #
      #         if @nugget_in == true
      #           part2 = @present3[@matching_lemma[0...-2].length..-1]
      #         else
      #           part2 = @present3[@matching_lemma.length..-1]
      #           #puts "This is part2 Ref: #{part2}"
      #         end
      #
      #         if @nugget_in == true
      #           part3 = @past3[@matching_lemma[0...-2].length..-1]
      #         else
      #           part3 = @past3[@matching_lemma.length..-1]
      #           #puts "This is part3 Ref: #{part3}"
      #         end
      #
      #         @file_name = "#{part1}_#{part2}_#{part3}"
      #         puts "RTLT #{@infinitive_form}:#{@file_name}"
      #
      #       elsif @reflexivity == false && @lemma_suffix_found == false
      #
      #         part1 = @infinitive_form[@from_first_vowel]
      #         part2 = @present3[@from_first_vowel]
      #         part3 = @past3[@from_first_vowel]
      #
      #         @file_name = "#{part1}_#{part2}_#{part3}"
      #         puts "RFLF #{@infinitive_form}:#{@file_name}"
      #
      #       elsif @reflexivity == true && @lemma_suffix_found == false
      #
      #         part1 = @infinitive_form[@from_first_vowel]
      #         part2 = @present3[@from_first_vowel]
      #         part3 = @past3[@from_first_vowel]
      #
      #         @file_name = "#{part1}_#{part2}_#{part3}"
      #         puts "RTLF #{@infinitive_form}:#{@file_name}"
      #
      #       else
      #         puts "Something has gone wrong"
      #       end
      #
      #       puts "This is the matching file name again: #{@file_name}"
      #     end
      #   end
      # end

      puts "Reflexive? #{@reflexivity} :: lemma? #{@lemma_suffix_found}"
      puts "#{@infinitive_form}: #{@infinitive_form.length}"
      puts "#{@present3}: #{@present3.length}"
      puts "#{@past3}: #{@past3.length}"
      "#{@file_name}"
      puts "lemma: #{@matching_lemma}, nugget: #{@nugget}"
      puts "#{@file_name}"
      puts ""

      file_name = @file_name
      x = file_name

    end

    def write_verb_forms_to_group_file(infinitive_verb)
      create_classificatory_file_name(infinitive_verb)

      output_verb_sequence = "#{@infinitive_form}, #{@present3}, #{@past3}\n"
      testing_output_verb_sequence = "[#{output_verb_sequence}]"
      file_path = @output_folder + @file_name + ".txt"

      # puts "#{infinitive_verb}: #{output_verb_sequence}"

      if File.exist?(file_path) == false

        # puts "No file for this pattern, creating a new one..."

        # new_verbs_array = "verbs_array = [#{output_verb_sequence}]"

        output_file = File.open(file_path, "w")
        output_file.write(output_verb_sequence)
        output_file.close

        # output_file = File.read(file_path, "a+")
        # verbs_array.push(output_verb_sequence)
        # output_file.write(verbs_array)
        # # output_file.write(output_verb_sequence)
        # # output_file.write(output_verb_sequence)
        # output_file.close

      elsif File.exists?(file_path) == true

        open_existing_file = File.open(file_path, "a+")
        inspection_file = File.readlines(open_existing_file)

        inspection_file.map do |line|
          # puts "This is the line before the split:"
          item = line.split(",")
          # puts "This is the item: #{item}"
          # puts "This is the first element: #{item[0]}"
          @test_for_duplicate = item[0].match?(@infinitive_form)
        end

        if @test_for_duplicate == true
          # puts "There is a match somewhere in the file"
        else
          # puts "no match found"
          # puts "Writing #{output_verb_sequence}"
          open_existing_file.write(output_verb_sequence)
          open_existing_file.close
          # puts "Now this is what the file looks like: #{inspection_file}"
        end
      end

      file_check = @inspection_results

    end
  end
end
