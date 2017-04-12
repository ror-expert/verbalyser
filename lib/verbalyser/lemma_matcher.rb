module Verbalyser
  class LemmaMatcher

    def initialize
      @output_folder = "output/matching_stems/"
      @lemma_database = File.readlines("data/lemmas_database.txt")
      @verb_database = File.readlines("data/verb_shortlist_core_conjugated.txt")
      @input_output = "matching_stem.txt"
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

      matching_stem = matching_stem_array.max

      # puts "This is the matching stem: #{matching_stem}"

      record_match_filename = @output_folder + "#{verb}_" + @input_output

      record_match = File.open(@output_folder + "#{verb}_" + @input_output, "w")
      record_match.write(matching_stem)
      record_match.close

      recorded_match = File.readlines(record_match_filename)

      # puts "processing #{verb}"
      # recorded_match.each { |lemma| puts "Matching lemma: #{lemma}"  }

    end
  end
end

# data_file = File.readlines("data/verb_shortlist_core_conjugated.txt")
# testing = Verbalyser::LemmaMatcher.new
# testing.find_longest_matching_lemma(data_file)
