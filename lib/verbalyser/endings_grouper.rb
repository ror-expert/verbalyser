require 'remove_accents'
require 'time'

module Verbalyser
  class EndingsGrouper
    def initialize
      @output_folder = "output/grouped/"

      # Database of lemmas: verb, noun, and adjectival stems
      @lemma_database = File.readlines("data/source_data/lemmas_database.txt")

      # Database of verbs in the three main forms:
      # infinitive, present-tense third-person, past-tense third-person
      @verb_database = File.readlines("data/source_data/verb_shortlist_core_conjugated_reflexive_eliminated.txt")

      # Useful in defining syllables
      @lithuanian_consonants = %w[b c č d f g h j k l m n p q r s š t v w x z ž ]

      # Useful in defining syllables
      # Also useful in identifying accented characters
      @lithuanian_vowels = %w[a ã à á ą ą̃ ą̀ ą́ e ẽ è é ę ę̃ ę̀ ę́ ė ė̃  ė̀  ė́  i ĩ ì í į̃  į̀ į į y ỹ ỳ ý o õ ò ó ũ ù ú u ų ų̃ ų̀ ų́ ū ū̃  ū̀  ū́]

      # Useful in indexing the beginning of the penultimate syllable
      @from_first_vowel = /[aãàáąą̃ą̀ą́eẽeẽèéęę̃ę̀ę́ėė̃ė̀ė́ė́iĩìíį̃į̀įįoõòóyỹỳýũùúuųų̃ų̀ų́ūū̃ū̀ū́](.*)/
      @accented_vowels = /[aãàáąą̃ą̀ą́eẽeẽèéęę̃ę̀ę́ėė̃ė̀ė́ė́iĩìíį̃į̀įįoõòóyỹỳýũùúuųų̃ų̀ų́ūū̃ū̀ū́]/

      @lithuanian_letters_diacritics_with_accents = {
        "ã" => ["\u00e3", "a"],
        "à" => ["\u00e0", "a"],
        "á" => ["\u00e1", "a"],
        "ą̀" => ["\u0105\u0300", "ą"],
        "ą́" => ["\u0105\u0301", "ą"],
        "ą̃" => ["\u0105\u0303", "ą"],
        "ẽ" => ["\u1ebd", "e"],
        "è" => ["\u00e8", "e"],
        "é" => ["\u00e9", "e"],
        "ę̀" => ["\u0119\u0300", "ę"],
        "ę́" => ["\u0119\u0301", "ę"],
        "ę̃" => ["\u0119\u0303", "ę"],
        "ė̀" => ["\u0117\u0300", "ė"],
        "ė́" => ["\u0117\u0301", "ė"],
        "ė̃" => ["\u0117\u0303", "ė"],
        "į̀" => ["\u012f", "į"],
        "į́" => ["\u012f", "į"],
        "į̃" => ["\u012f", "į"],
        "ì" => ["\u00ec", "į"],
        "í" => ["\u00ed", "į"],
        "ĩ" => ["\u0129", "į"],
        "ò" => ["\u00f2", "o"],
        "ó" => ["\u00f3", "o"],
        "õ" => ["\u00f5", "o"],
        "ù" => ["\u00f9", "u"],
        "ú" => ["\u00fa", "u"],
        "ũ" => ["\u0169", "u"],
        "ų̀" => ["\u0173\u0300", "ų"],
        "ų́" => ["\u0173\u0301", "ų"],
        "ų̃" => ["\u0173\u0303", "ų"],
        "ū̀" => ["\u016b\u0300", "ū"],
        "ū́" => ["\u016b\u0301", "ū"],
        "ū̃" => ["\u016b\u0303", "ū"],
        "ỳ" => ["\u1ef3", "y"],
        "ý" => ["\u00fd", "y"],
        "ỹ" => ["\u1ef9", "y"],
        "l̀" => ["\u006c\u0300", "l"],
        "ĺ" => ["\u013a", "l"],
        "l̃" => ["\u006c\u0303", "l"],
        "m̀" => ["\u006d\u0300", "m"],
        "ḿ" => ["\u1e3f", "m"],
        "m̃" => ["\u006d\u0303", "m"],
        "ǹ" => ["\u01f9", "n"],
        "ń" => ["\u0144", "n"],
        "ñ" => ["\u00f1", "n"],
        "r̀" => ["\u0072\u0300", "r"],
        "ŕ" => ["\u0155", "r"],
        "r̃" => ["\u0072\u0303", "r"]
      }
      # For recording files that are obviously unusual
      # e.g. too long, too short, etc.
      # @suspect_path = File.open("spec/review/suspicious_filenames_#{Time.now}.txt", "a+")
    end

    # May not be necessary after all, keeping it for now.
    def get_unicode(char)
      (0..55295).each do |pos|
      # (0..109976).each do |pos|
        chr = ""
        chr << pos
        if chr == char
          @unicode_value = pos.to_s(16)
          puts "This is the unicode of #{char}: #{@unicode_value}"
        end
      end
      unicode_value = @unicode_value
    end

    def slice_and_scrub_accents(verb_slice)
      lithuanian_letters_diacritics_with_accents = {
        "̀" => ["\u0300", ""],
        "́" => ["\u0301", ""],
        "̃" => ["\u0303", ""],
        "ã" => ["\u00e3", "a"],
        "à" => ["\u00e0", "a"],
        "á" => ["\u00e1", "a"],
        "ą̀" => ["\u0105\u0300", "ą"],
        "ą́" => ["\u0105\u0301", "ą"],
        "ą̃" => ["\u0105\u0303", "ą"],
        "ẽ" => ["\u1ebd", "e"],
        "è" => ["\u00e8", "e"],
        "é" => ["\u00e9", "e"],
        "ę̀" => ["\u0119\u0300", "ę"],
        "ę́" => ["\u0119\u0301", "ę"],
        "ę̃" => ["\u0119\u0303", "ę"],
        "ė̀" => ["\u0117\u0300", "ė"],
        "ė́" => ["\u0117\u0301", "ė"],
        "ė̃" => ["\u0117\u0303", "ė"],
        "į̀" => ["\u012f", "į"],
        "į́" => ["\u012f", "į"],
        "į̃" => ["\u012f", "į"],
        "ì" => ["\u00ec", "į"],
        "í" => ["\u00ed", "į"],
        "ĩ" => ["\u0129", "į"],
        "ò" => ["\u00f2", "o"],
        "ó" => ["\u00f3", "o"],
        "õ" => ["\u00f5", "o"],
        "ù" => ["\u00f9", "u"],
        "ú" => ["\u00fa", "u"],
        "ũ" => ["\u0169", "u"],
        "ų̀" => ["\u0173\u0300", "ų"],
        "ų́" => ["\u0173\u0301", "ų"],
        "ų̃" => ["\u0173\u0303", "ų"],
        "ū̀" => ["\u016b\u0300", "ū"],
        "ū́" => ["\u016b\u0301", "ū"],
        "ū̃" => ["\u016b\u0303", "ū"],
        "ỳ" => ["\u1ef3", "y"],
        "ý" => ["\u00fd", "y"],
        "ỹ" => ["\u1ef9", "y"],
        "l̀" => ["\u006c\u0300", "l"],
        "ĺ" => ["\u013a", "l"],
        "l̃" => ["\u006c\u0303", "l"],
        "m̀" => ["\u006d\u0300", "m"],
        "ḿ" => ["\u1e3f", "m"],
        "m̃" => ["\u006d\u0303", "m"],
        "ǹ" => ["\u01f9", "n"],
        "ń" => ["\u0144", "n"],
        "ñ" => ["\u00f1", "n"],
        "r̀" => ["\u0072\u0300", "r"],
        "ŕ" => ["\u0155", "r"],
        "r̃" => ["\u0072\u0303", "r"]
      }

      # explode = verb_slice.split("")
      # explode.each do |letter|
      #   get_unicode(letter)
      # end

      lithuanian_letters_diacritics_with_accents.each do |key, value|
        if verb_slice.index(key) != nil
          # puts "found: #{verb_slice[verb_slice.index(key)]} in #{verb_slice}"
          accented_letter = verb_slice[verb_slice.index(key)]
          unaccented_letter = value[1]
          verb_slice = verb_slice.sub!(accented_letter, unaccented_letter)
          # puts "new = #{verb_slice}"
        end
      end

      @clean_slice = verb_slice
    end

    # Lithuanian verb ending in "ti" is non-reflexive;
    # Lithuanian verb ending in "tis" is reflexive:
    # An important distinction, for complicated reasons.
    def identify_whether_verb_is_reflexive(infinitive_verb)
      if infinitive_verb.strip[-2,2] == "ti"
        @reflexivity = false
        @stripped_infinitive_verb = infinitive_verb[0...-2]
      end

      if infinitive_verb.strip[-3,3] == "tis"
        @reflexivity = true
        @stripped_infinitive_verb = infinitive_verb[0...-3]
      end

      # RSpec won't pass unless I declare this redundant variable.
      # I'm yet to understand why.
      verb_reflexivity = @reflexivity
    end

    # The stripped verb will be supplied the method
    # create_classificatory_file_name
    def check_for_lemma_suffix(stripped_verb)

      matching_stem_array = Array.new
      stems = (0..stripped_verb.size - 1).each_with_object([]) {|i, subs| subs << stripped_verb[0..i]}

      stems.each do |stem|
        @lemma_database.each do |lemma|
          if lemma[0] == stem[0] && lemma.strip == stem
            matching_stem_array.push(stem.strip)
          end
        end
      end
      @matching_lemma = matching_stem_array.max

      # nugget is a lemma suffix
      if stripped_verb[@matching_lemma.length..-1].length > 0
        @nugget = stripped_verb[@matching_lemma.length..-1]
      else
        @nugget = ""
      end


      if @nugget.length > 0
        @nugget_found = true
      else
        @nugget_found = false
      end

      nugget_found = @nugget_found


    end


    # Takes the infinitive verb because
    # it will be stripped by the preceding method
    def create_classificatory_file_name(infinitive_verb)

      # Defines the reflexivity boolean value
      identify_whether_verb_is_reflexive(infinitive_verb)

      # Defines the lemma suffix string
      check_for_lemma_suffix(@stripped_infinitive_verb)

      # Defines the three main verb forms needed
      @verb_database.each do |line|
        verb_array = line.strip.split(",")

        # I'd like to something better than cycling through with simple
        # conditionals, but it's the best I've got at the moment
        if verb_array[0].strip == infinitive_verb

          # File name is derived from the three main forms,
          # infinitive is already supplied
          # infinitive_verb = verb_array[0].strip
          puts "infinitive: #{infinitive_verb}"
          @present3_form = verb_array[1].strip
          puts "present3: #{@present3_form}"
          @past3_form = verb_array[2].strip
          puts "past3: #{@past3_form}"
          puts "nugget: #{@nugget}, #{@nugget_found}"
          puts "matching lemma = #{@matching_lemma}"

          # I keep the terminal output to a minimum,
          # but this helps when running the code
        end
      end

      case
      when @nugget_found == true

        @infinitive_slice = infinitive_verb[@matching_lemma.length..-1]
        @present3_slice = @present3_form[@matching_lemma.length..-1]
        @past3_slice = @past3_form[@matching_lemma.length..-1]
      when @nugget_found == false

        case
        when infinitive_verb.match?(/\S*asti*/)
          @new_matching_lemma_index = infinitive_verb.index("asti")
        when infinitive_verb.match?(/\S*yšti*/)
          @new_matching_lemma_index = infinitive_verb.index("yšti")
        when infinitive_verb.match?(/\S*ešti*/)
          @new_matching_lemma_index = infinitive_verb.index("ešti")
        when infinitive_verb.match?(/\S*eigti*/)
          @new_matching_lemma_index = infinitive_verb.index("eigti")
        when infinitive_verb.match?(/\S*iešti*/)
          @new_matching_lemma_index = infinitive_verb.index("iešti")
        when infinitive_verb.match?(/\S*esti*/)
          @new_matching_lemma_index = infinitive_verb.index("esti")
        when infinitive_verb.match?(/\S*iepti*/)
          @new_matching_lemma_index = infinitive_verb.index("iepti")
        when infinitive_verb.match?(/\S*ėkti*/)
          @new_matching_lemma_index = infinitive_verb.index("ėkti")
        when infinitive_verb.match?(/\S*aukti*/)
          @new_matching_lemma_index = infinitive_verb.index("aukti")
        when infinitive_verb.match?(/\S*ykti*/)
          @new_matching_lemma_index = infinitive_verb.index("ykti")
        when infinitive_verb.match?(/\S*aupti*/)
          @new_matching_lemma_index = infinitive_verb.index("aupti")
        when infinitive_verb.match?(/\S*eikti*/)
          @new_matching_lemma_index = infinitive_verb.index("eikti")
        when infinitive_verb.match?(/\S*aisti*/)
          @new_matching_lemma_index = infinitive_verb.index("aisti")
        when infinitive_verb.match?(/\S*ūsti*/)
          @new_matching_lemma_index = infinitive_verb.index("ūsti")
        when infinitive_verb.match?(/\S*elkti*/)
          @new_matching_lemma_index = infinitive_verb.index("elkti")
        when infinitive_verb.match?(/\S*umti*/)
          @new_matching_lemma_index = infinitive_verb.index("umti")
        when infinitive_verb.match?(/\S*elsti*/)
          @new_matching_lemma_index = infinitive_verb.index("elsti")
        when infinitive_verb.match?(/\S*irbti*/)
          @new_matching_lemma_index = infinitive_verb.index("irbti")
        when infinitive_verb.match?(/\S*ėgti*/)
        when !@infinitive_slice.match?(/\S*uoti*/) && @infinitive_slice.match?(/\S*oti*/)
          @new_matching_lemma_index = infinitive_verb.index("oti")
          @new_matching_lemma_index = infinitive_verb.index("ėgti")
        when infinitive_verb.match?(/\S*erti*/)
          @new_matching_lemma_index = infinitive_verb.index("erti")
        when infinitive_verb.match?(/\S*ėti*/)
          @new_matching_lemma_index = infinitive_verb.index("ėti")
        when infinitive_verb.match?(/\S*uoti/)
          @new_matching_lemma_index = infinitive_verb.index("uoti")
        when infinitive_verb.match?(/\S*[bcčdfghjklmnpqrsštvwxzž]ytis/)
          @new_matching_lemma_index = infinitive_verb.index("ytis")
        when infinitive_verb.match?(/\S*[bcčdfghjklmnpqrsštvwxzž]yti/)
          @new_matching_lemma_index = infinitive_verb.index("yti")
        when infinitive_verb.match?(/\S*auti*/)
          @new_matching_lemma_index = infinitive_verb.index("auti")
        when infinitive_verb.match?(/\S*enti*/)
          @new_matching_lemma_index = infinitive_verb.index("enti")
        when infinitive_verb.match?(/\S*inti*/)
          @new_matching_lemma_index = infinitive_verb.index("inti")
        when infinitive_verb.match?(/\S*ęsti*/)
          @new_matching_lemma_index = infinitive_verb.index("ęsti")
        when infinitive_verb.match?(/\S*urti*/)
          @new_matching_lemma_index = infinitive_verb.index("urti")
        when infinitive_verb.match?(/\S*ūti*/)
          @new_matching_lemma_index = infinitive_verb.index("ūti")
        when infinitive_verb.match?(/\S*ybti*/)
          @new_matching_lemma_index = infinitive_verb.index("ybti")
        when infinitive_verb.match?(/\S*izti*/)
          @new_matching_lemma_index = infinitive_verb.index("izti")
        when infinitive_verb.match?(/\S*ąsti*/)
          @new_matching_lemma_index = infinitive_verb.index("ąsti")
        when infinitive_verb.match?(/\S*iaukti*/)
          @new_matching_lemma_index = infinitive_verb.index("iaukti")
        when infinitive_verb.match?(/\S*elti*/)
          @new_matching_lemma_index = infinitive_verb.index("elti")
        when infinitive_verb.match?(/\S*kšti*/)
          @new_matching_lemma_index = infinitive_verb.index("kšti")
        when infinitive_verb.match?(/\S*pšti*/)
          @new_matching_lemma_index = infinitive_verb.index("pšti")
        when infinitive_verb.match?(/\S*isti*/)
          @new_matching_lemma_index = infinitive_verb.index("isti")
        when infinitive_verb.match?(/\S*yžti*/)
          @new_matching_lemma_index = infinitive_verb.index("yžti")
        when infinitive_verb.match?(/\S*ųsti*/)
          @new_matching_lemma_index = infinitive_verb.index("ųsti")
        else
          puts "no other matches"
          @new_matching_lemma_index = infinitive_verb.index("ti")
        end

        puts "verb = #{infinitive_verb}, new matching lemma index = #{@new_matching_lemma_index}"

        @infinitive_slice = infinitive_verb[@new_matching_lemma_index..-1]
        puts "infinitive slice = #{@infinitive_slice}"
        @present3_slice = @present3_form[@new_matching_lemma_index..-1]
        puts "present3 slice = #{@present3_slice}"
        @past3_slice = @past3_form[@new_matching_lemma_index..-1]
        puts "past3 slice = #{@past3_slice}"

      end

      @file_name = "#{@infinitive_slice}_#{@present3_slice}_#{@past3_slice}"

      slice_and_scrub_accents(@file_name)

      puts "This is the file name: #{@file_name}"

      file_name = @file_name

    end

    def write_verb_forms_to_group_file(infinitive_verb)
      create_classificatory_file_name(infinitive_verb)

      output_verb_sequence = "#{infinitive_verb}, #{@present3_form}, #{@past3_form}\n"
      testing_output_verb_sequence = "[#{output_verb_sequence}]"
      file_path = @output_folder + @file_name + ".txt"

      if File.exists?(file_path) == false

        puts "No file for #{@file_name}, creating a new one..."
        output_file = File.open(file_path, "w")
        output_file.write(output_verb_sequence)
        output_file.close
      elsif File.exists?(file_path) == true

        open_existing_file = File.open(file_path, "a+")
        inspection_file = File.readlines(file_path, "a+")

        inspection_file.map do |line|
          item = line.split(",")
          @test_for_duplicate = item[0].match?(infinitive_verb)
        end

        if @test_for_duplicate == false
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
