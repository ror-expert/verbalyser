module Verbalyser
  class VerbShortlister

    def initialize

      @output_folder = "output"

      @verb_full_list = "#{@output_folder}/verb_list_cleaned.txt"

      @verb_shortlist_core = "#{@output_folder}/verb_shortlist_core.txt"

      @verb_shortlist_ex_reflexive = "#{@output_folder}/verb_shortlist_ex_reflexive.txt"
      @verb_shortlist_ex_non_reflexive = "#{@output_folder}/verb_shortlist_ex_non_reflexive.txt"

      @verb_prefixes_non_reflexive = %w[ap at į iš nu pa par per pra pri su už be]
      @verb_prefixes_reflexive = %w[apsi atsi įsi išsi nusi pasi parsi persi prasi prisi susi užsi]

      @probably_unprefixed = Array.new

    end

    # This misses verbs that do not appear
    # in un-prefixed form on this list
    def shortlist_non_prefixed_verbs
      raw_data = File.readlines(@verb_full_list)
      output_file = File.open(@verb_shortlist_core, "w")

      raw_data.each do |verb|

        if !@verb_prefixes_non_reflexive.index { |prefix| verb[0..prefix.length].include?(prefix)}
          puts "Here is a verb with prefix: #{verb}"
          @probably_unprefixed.push(verb)
          output_file.write(verb)
        end
      end

      output_file.close

      puts "full verb list count: #{raw_data.length}"
      puts "probably_unprefixed verbs count: #{@probably_unprefixed.length}"
      review_verb_shortlist_core = File.readlines(@verb_shortlist_core)

    end
  end
end

# testing = Verbalyser::VerbShortlister.new
# testing.shortlist_non_prefixed_verbs
