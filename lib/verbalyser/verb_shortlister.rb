module Verbalyser
  class VerbShortlister

    def initialize

      @output_folder = "output"

      @verb_full_list = "#{@output_folder}/verb_list_cleaned.txt"

      @verb_shortlist_core = "#{@output_folder}/verb_shortlist_core.txt"

      @verb_shortlist_ex_reflexive = "#{@output_folder}/verb_shortlist_ex_reflexive.txt"
      @verb_shortlist_ex_non_reflexive = "#{@output_folder}/verb_shortlist_ex_non_reflexive.txt"

      @verb_prefixes_non_reflexive = %w[ap į iš nu pa par per pra pri su už]
      @verb_prefixes_reflexive = %w[apsi įsi išsi nusi pasi parsi persi prasi prisi susi užsi]

    end

    def shortlist_non_prefixed_verbs
      raw_data = File.readlines(@verb_full_list)
      output_file = File.open(@verb_shortlist_core, "w")

      raw_data.each do |verb|
        @verb_prefixes_non_reflexive.each do |non_reflexive_prefix|
          @verb_prefixes_reflexive.each do |reflexive_prefix|

            length_non_reflexive_prefix = non_reflexive_prefix.length
            length_reflexive_prefix = reflexive_prefix.length

            if verb[0...length_non_reflexive_prefix] == non_reflexive_prefix
              # puts "non_reflexive_prefix verb: #{verb} with #{non_reflexive_prefix}"
            elsif verb[0...length_reflexive_prefix] == reflexive_prefix
              # puts "reflexive_prefix verb: #{verb} with #{reflexive_prefix}"
            else
              puts "non_prefixed_verb: #{verb}"
              output_file.write("#{verb}")
            end

          end


        end
      end


      output_file.close
      review_verb_shortlist_core = File.readlines(@verb_shortlist_core)


    end
  end
end

testing = Verbalyser::VerbShortlister.new
testing.shortlist_non_prefixed_verbs
