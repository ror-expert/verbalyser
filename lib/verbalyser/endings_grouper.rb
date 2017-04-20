require 'remove_accents'
require 'time'

module Verbalyser
  class EndingsGrouper

    def initialize
      @output_folder = "output/grouped/"
      @lemma_database = File.readlines("data/lemmas_database.txt")
      @verb_database = File.readlines("data/verb_shortlist_core_conjugated.txt")
      @input_output = "matching_stem.txt"

      @lithuanian_consonants = %w[b c č d f g h j k l m n p q r s š t v z ž]

      # @lithuanian_consonants_set = [bcčdfghjklmnpqrsštvwxzž]

      @lithuanian_vowels = %w[a ã à á ą ą̃ ą̀ ą́ e ẽ è é ę ę̃ ę̀ ę́ ė ė̃  ė̀  ė́  i ĩ ì í į̃  į̀ į į y ỹ ỳ ý o õ ò ó ũ ù ú u ų ų̃ ų̀ ų́ ū ū̃  ū̀  ū́]

      @from_first_vowel = /[aãàáąą̃ą̀ą́eẽeẽèéęę̃ę̀ę́ėė̃ė̀ė́ė́iĩìíį̃į̀įįoõòóyỹỳýũùúuųų̃ų̀ų́ūū̃ū̀ū́](.*)/

      @accented_vowels = /[ãàáąą̃ą̀ą́ẽeẽèéę̃ę̀ę́ė̀ė́ė́iĩìíį̀įįõòóỹỳýũùúų̃ų̀ų́ūū̃ū̀ū́]/

      @suspect_path = File.open("spec/review/suspicious_filenames_#{Time.now}.txt", "a+")

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

      if stripped_verb[-2,2] == "in"
        @nugget = "in"
        @nugget_in = true
        @matching_lemma = stripped_verb[0...-2]
      elsif @matching_lemma[-2,2] == "in"
        @nugget = "in"
        @nugget_in = true
        @matching_lemma = @matching_lemma[0...-2]
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
      # puts "nugget_n: #{@nugget_n}"
      # puts "lemma_in: #{@lemma_in}"
      # puts "lemma_n: #{@lemma_n}"

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
        if @nugget.length > 0
          if @nugget_in == true
            puts "LEMMA (#{@matching_lemma}) and NUGGET -IN- (#{@nugget})"
            @key_substring = "lemma_nugget_in"
          else
            puts "LEMMA (#{@matching_lemma}) and NUGGET (#{@nugget})"
            @key_substring = "lemma_nugget_general"
          end
        else
          puts "LEMMA (#{@matching_lemma}) only"
          @key_substring = "lemma_only"
        end
      else
        puts "THERE IS A PROBLEM HERE"
        @key_substring = "lemma_not_found"
      end

      case @key_substring
      when "lemma_nugget_general"
        puts "CLASSIFICATION: lemma_nugget_general"
        puts "NUGGET: #{@nugget}"

        @infinitive_slice = @infinitive_form.removeaccents.sub("\u0301", "").sub("\u0302", "").sub("\u0303", "").sub("\u1ef9", "y").sub("ū́", "ū").sub("m̃", "m")[@matching_lemma.length..-1]
        @present3_slice = @present3.removeaccents.sub("\u0301", "").sub("\u0302", "").sub("\u0303", "").sub("\u1ef9", "y").sub("ū́", "ū").sub("m̃", "m")[@matching_lemma.length..-1]
        @past3_slice = @past3.removeaccents.sub("\u0301", "").sub("\u0302", "").sub("\u0303", "").sub("\u1ef9", "y").sub("ū́", "ū").sub("m̃", "m")[@matching_lemma.length..-1]
        @file_name = "#{@infinitive_slice}_#{@present3_slice}_#{@past3_slice}"

      when "lemma_nugget_in"
        puts "CLASSIFICATION: lemma_nugget_in"

        @infinitive_slice = @infinitive_form.removeaccents.sub("\u0301", "").sub("\u0302", "").sub("\u0303", "").sub("\u1ef9", "y").sub("ū́", "ū").sub("m̃", "m")[@matching_lemma.length..-1]
        @present3_slice = @present3.removeaccents.sub("\u0301", "").sub("\u0302", "").sub("\u0303", "").sub("\u1ef9", "y").sub("ū́", "ū").sub("m̃", "m")[@matching_lemma.length..-1]
        @past3_slice = @past3.removeaccents.sub("\u0301", "").sub("\u0302", "").sub("\u0303", "").sub("\u1ef9", "y").sub("ū́", "ū").sub("m̃", "m")[@matching_lemma.length..-1]
        @file_name = "#{@infinitive_slice}_#{@present3_slice}_#{@past3_slice}"

      when "lemma_only"
        puts "CLASSIFICATION: lemma_only"

        @infinitive_slice = @infinitive_form.removeaccents.sub("\u0301", "").sub("\u0302", "").sub("\u0303", "").sub("\u1ef9", "y").sub("ū́", "ū").sub("m̃", "m")[@matching_lemma.length..-1]
        @present3_slice = @present3.removeaccents.sub("\u0301", "").sub("\u0302", "").sub("\u0303", "").sub("\u1ef9", "y").sub("ū́", "ū").sub("m̃", "m")[@matching_lemma.length..-1]
        @past3_slice = @past3.removeaccents.sub("\u0301", "").sub("\u0302", "").sub("\u0303", "").sub("\u1ef9", "y").sub("ū́", "ū").sub("m̃", "m")[@matching_lemma.length..-1]
        @file_name = "#{@infinitive_slice}_#{@present3_slice}_#{@past3_slice}"
      when "lemma_not_found"
        puts "WARNING: lemma_not_found"
      else
        puts "WARNING: THERE IS A PROBLEM HERE"
      end

      case
      when @infinitive_slice.match?(/\S*ėti/)

        @new_matching_lemma = @infinitive_form.index("ėti")

        puts "This ends in -ėti"
        puts "old matching_lemma: #{@matching_lemma}"
        puts "trying to extend the matching_lemma"
        puts "ėti is here: #{@new_matching_lemma}"

        @present3 = @present3.sub("ū́", "ū").sub("ė́", "ė").sub("m̃", "m")
        @past3 = @past3.sub("ū́", "ū").sub("ė́", "ė").sub("m̃", "m")


        @infinitive_slice = @infinitive_form[@new_matching_lemma..-1]
        @present3_slice = @present3.removeaccents.sub("\u0301", "")[@new_matching_lemma..-1]
        @past3_slice = @past3.removeaccents.sub("\u0301", "")[@new_matching_lemma..-1]
        @file_name = "#{@infinitive_slice}_#{@present3_slice}_#{@past3_slice}".removeaccents

      when @infinitive_slice.match?(/\Seti/)

        @new_matching_lemma = @infinitive_form.index("eti")

        puts "This ends in -eti"
        puts "old matching_lemma: #{@matching_lemma}"
        puts "trying to extend the matching_lemma"
        puts "ėti is here: #{@new_matching_lemma}"

        @infinitive_slice = @infinitive_form[@new_matching_lemma..-1]
        @present3_slice = @present3.removeaccents.sub("\u0301", "")[@new_matching_lemma..-1]
        @past3_slice = @past3.removeaccents.sub("\u0301", "")[@new_matching_lemma..-1]
        @file_name = "#{@infinitive_slice}_#{@present3_slice}_#{@past3_slice}".removeaccents

      when @infinitive_slice.match?(/\S*uoti/)

        @new_matching_lemma = @infinitive_form.index("uoti")

        puts "This ends in -uoti"
        puts "old matching_lemma: #{@matching_lemma}"
        puts "trying to extend the matching_lemma"
        puts "ėti is here: #{@new_matching_lemma}"

        @infinitive_slice = @infinitive_form[@new_matching_lemma..-1]
        @present3_slice = @present3[@new_matching_lemma..-1]
        @past3_slice = @past3[@new_matching_lemma..-1]
        @file_name = "#{@infinitive_slice}_#{@present3_slice}_#{@past3_slice}".removeaccents

      when !@infinitive_slice.match?(/\S*uoti/) && @infinitive_slice.match?(/\S*oti/)

        @new_matching_lemma = @infinitive_form.index("oti")

        puts "This ends in -oti but not -uoti"
        puts "old matching_lemma: #{@matching_lemma}"
        puts "trying to extend the matching_lemma"
        puts "ėti is here: #{@new_matching_lemma}"

        @infinitive_slice = @infinitive_form[@new_matching_lemma..-1]
        @present3_slice = @present3[@new_matching_lemma..-1]
        @past3_slice = @past3[@new_matching_lemma..-1]
        @file_name = "#{@infinitive_slice}_#{@present3_slice}_#{@past3_slice}".removeaccents

      when @infinitive_slice.match?(/\S*[bcčdfghjklmnpqrsštvwxzž]yti/)

        @new_matching_lemma = @infinitive_form.index("yti")

        # if @present3.include?("\u0072\u0303")
        #   puts "found a word with a tilde r: #{@present3}"
        #   puts "now without: #{@present3.sub("\u0303", "")}"
        # end

        puts "This ends in -yti"
        puts "old matching_lemma: #{@matching_lemma}"
        puts "trying to extend the matching_lemma"
        puts "yti is here: #{@new_matching_lemma}"
        puts "length of #{@present3}: #{@present3.length}, minus accents #{@present3.removeaccents} #{@present3.removeaccents.length}"

        @infinitive_slice = @infinitive_form[@new_matching_lemma..-1]
        @present3_slice = @present3.removeaccents.sub("\u0303", "")[(@new_matching_lemma)..-1]
        @past3_slice = @past3.removeaccents.sub("\u0303", "")[(@new_matching_lemma)..-1]
        @file_name = "#{@infinitive_slice}_#{@present3_slice}_#{@past3_slice}".removeaccents

      when @infinitive_slice.match?(/\S*auti/)

        @new_matching_lemma = @infinitive_form.index("auti")
        @present3 = @present3.sub("ū́", "ū").sub("ė́", "ė")
        @past3 = @past3.sub("ū́", "ū").sub("ė́", "ė")

        # if @present3.include?("\u0072\u0303")
        #   puts "found a word with a tilde r: #{@present3}"
        #   puts "now without: #{@present3.sub("\u0303", "")}"
        # end

        puts "This ends in -auti"
        puts "old matching_lemma: #{@matching_lemma}"
        puts "trying to extend the matching_lemma"
        puts "auti is here: #{@new_matching_lemma}"
        puts "length of #{@present3}: #{@present3.length}, minus accents #{@present3.removeaccents} #{@present3.removeaccents.length}"
        puts "length of #{@past3}: #{@past3.length}, minus accents #{@past3.removeaccents.sub("ū́", "ū")} #{@past3.removeaccents.sub("ū́", "ū").length}"

        @infinitive_slice = @infinitive_form[@new_matching_lemma..-1]
        @present3_slice = @present3.removeaccents.sub("\u0303", "")[(@new_matching_lemma)..-1]
        @past3_slice = @past3.removeaccents.sub("\u0303", "")[(@new_matching_lemma)..-1]
        @file_name = "#{@infinitive_slice}_#{@present3_slice}_#{@past3_slice}".removeaccents

      end


      puts "infinitive_form: #{@infinitive_slice}"
      puts "present3_slice: #{@present3_slice}"
      puts "past3_slice: #{@past3_slice}"
      puts "file_name: #{@file_name}"

      puts "\n**************************************\n\n"

      file_name = @file_name
      x = file_name

    end

    def write_verb_forms_to_group_file(infinitive_verb)
      create_classificatory_file_name(infinitive_verb)

      output_verb_sequence = "#{@infinitive_form}, #{@present3}, #{@past3}\n"
      testing_output_verb_sequence = "[#{output_verb_sequence}]"
      file_path = @output_folder + @file_name.removeaccents + ".txt"

      if file_path.include?("\u1ef9")
        puts "Found Y with tilde"
      end



      if @reflexivity == false && @infinitive_slice.length > 4
        @suspect_path.write("#{infinitive_verb}, #{@file_name}\n")
      elsif @reflexivity == true && @infinitive_slice.length > 5
        @suspect_path.write("#{infinitive_verb}, #{@file_name}\n")
      end

      if File.exist?(file_path) == false

         puts "No file for this pattern (#{infinitive_verb}), creating a new one..."

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
