module Verbalyser
  class LemmaDatabaseFetcher

    def initialize
      @source_folder = "data/lemma_database/"
      @source_filename = "lemmas_database.txt"
      @lemma_database = File.open("#{@source_folder}#{@source_filename}")
      @verb_prefixes_non_reflexive = %w[ap į iš nu pa par per pra pri su už]
      @verb_prefixes_reflexive = %w[apsi įsi išsi nusi pasi parsi persi prasi prisi susi užsi]
      @preliminary_verb_array = Array.new
      @core_verb_array = Array.new
      @verb_folder = Dir["spec/fixtures/*"]

    end

    def fetch_lemma_database
      File.readlines(@source_file).each do |line|
        print line
      end
    end

    def verb_check
      verb_list = %w[apkalti įkalti įsikalti perkalti prikalti sukalti užkalti]

      verb_list.each do |verb|
        File.readlines(@source_file).each do |stem|
          # puts "#{stem} is a #{stem.class}"
          if stem.strip == "kal"
            # puts "found #{stem}"
          end

          probable_stem = verb[0...-2]

          # puts probable_stem.strip

          if probable_stem.strip == stem.strip
            puts "found a stem for #{verb}: #{stem.strip}"
          end

        end
      end


    end


    def strip_verbs
      verb_folder = Dir["spec/fixtures/*"]

      verb_folder.each do |filename|
        source_file = File.open(filename, "r")
        source_file.each do |verb|
          @verb_prefixes.each do |prefix|
            verb = verb.strip
            prefix = prefix.strip
            prefix_length = prefix.length
            if verb[0] == prefix[0] && verb[0..prefix_length] == prefix
              puts "Verb #{verb.strip} has this probable prefix #{prefix.strip}"
              # puts "This is the length of the prefix #{prefix.strip} in the verb: #{prefix.strip.length}"
              # puts "#{verb[0..]}"
            end
          end
        end
      end


      # verb_folder.each do |filename|
      #   source_file = File.open(filename, "r")
      #   source_file.each do |verb|
      #     # puts "#{filename}: #{line}"
      #     @verb_prefixes.each do |prefix|
      #       # puts prefix
      #       if prefix[0] == verb[0]
      #         # puts "Prefixed verb? #{verb}"
      #         if verb.include?(prefix)
      #           prefix_length = prefix.length
      #           stripped_verb = verb[prefix.length..-1]
      #           # puts stripped_verb
      #           # puts "#{stripped_verb[0..1]}"
      #           if stripped_verb[0..1] == "si"
      #             # puts "reflexive verb? #{stripped_verb}"
      #             restripped_verb = stripped_verb[2..-1]
      #             puts restripped_verb
      #           end
      #         end
      #       end
      #     end
      #   end
      # end

      # verb_folder.each do |filename|
      #   source_file = File.open(filename, "r")
      #   source_file.each do |verb|
      #     @verb_prefixes.each do |prefix|
      #       if prefix[0] == verb[0] && verb.include?(prefix) == true
      #         stripped_verb = verb[prefix.length..-1]
      #         # puts stripped_verb
      #         if stripped_verb[0...2] == "si"
      #           # puts "reflexive: #{stripped_verb}"
      #           restripped_verb = stripped_verb[2..-1]
      #           puts restripped_verb
      #           @verb_array.push(restripped_verb.strip)
      #         else
      #           unrestripped_verb = stripped_verb
      #           @verb_array.push(unrestripped_verb.strip)
      #         end
      #       end
      #     end
      #   end
      # end
      #
      # verb_folder.each do |filename|
      #   source_file = File.open(filename, "r")
      #   source_file.each do |verb|
      #     @verb_prefixes.each do |prefix|
      #       @lemma_database.each do |lemma|
      #         if prefix[0] == verb[0] && verb.include?(prefix) == true
      #           pass_1_verb = verb[prefix.length..-1]
      #           if pass_1_verb[0...2] == "si"
      #
      #             matching_lemmas = Array.new
      #
      #           end
      #         end
      #       end
      #     end
      #   end
      # end


      # output_folder = "data/verbs_database/"
      # output_filename = "stripped_verbs.txt"
      # output_file = "#{output_folder}#{output_filename}"
      # open_output_file = File.open(output_file, "w")

      # verb_folder.each do |filename|
      #   source_file = File.open(filename, "r")
      #   source_file.each do |verb|
      #     # puts "This is verb #{verb_counter}"
      #     # print verb
      #     verb_counter += 1
      #     @lemma_database.each do |lemma|
      #       puts "This is #{lemma_counter} #{lemma.strip} and #{verb_counter} #{verb.strip}"
      #       lemma_counter += 1
      #     end
      #   end
      # end

      # verb_counter = 0
      # lemma_counter = 0
      # matching_lemmas = Array.new
      #
      # @lemma_database.each do |lemma|
      #   lemma_counter += 1
      #   verb_folder.each do |filename|
      #   source_file = File.open(filename, "r")
      #     source_file.each do |verb|
      #
      #       # puts "Verb #{verb_counter}: #{verb.strip} and lemma #{lemma_counter}: #{lemma.strip}"
      #       verb_counter += 1
      #
      #       if verb.strip.include?(lemma.strip)
      #         # puts "The verb #{verb.strip} includes #{lemma.strip}"
      #         matching_lemmas.push(lemma.strip)
      #         puts "this is the matching_lemmas array:"
      #         print matching_lemmas
      #       end
      #     end
      #   end
      # end

      # 1. Create an array of verbs with probable prefixes
      # 2. Create a shortlist of lemma starting with "si"
      # 2. Match every verb to the longest matching lemma
      # 3.




      # puts "This is the verb array: "
      # print @verb_array
      #
      # refined_verb_array = @verb_array.uniq
      #
      # puts "This is the refined verb array"
      # print refined_verb_array
      #
      # puts "verb array: #{@verb_array.length}"
      # puts "refined_verb_array: #{refined_verb_array.length}"


      # refined_verb_array.each do |refined_verb|
      #   open_output_file.write("#{refined_verb}\n")
      # end

    end

    def shortlist_verbs

      verb_counter = 0
      reflexive_prefix_match_counter = 0

      @verb_folder.each do |filename|
        File.open(filename, "r").each do |verb|
          verb = verb.strip
          @core_verb_array.push(verb)
        end
      end

      print @core_verb_array
      puts "core_verb_array at the start: #{@core_verb_array.length}"

      @verb_folder.each do |filename|
        File.open(filename, "r").each do |verb|
          @verb_prefixes_reflexive.each do |reflexive_prefix|
            verb = verb.strip
            reflexive_prefix = reflexive_prefix.strip
            reflexive_prefix_length = reflexive_prefix.length

            if verb[0] == reflexive_prefix[0] && verb[0...reflexive_prefix.length] == reflexive_prefix
              reflexive_prefix_match_counter += 1
              stripped_reflexive_prefix_verb = verb[reflexive_prefix_length..-1]
              # puts stripped_reflexive_prefix_verb
              @preliminary_verb_array.push(stripped_reflexive_prefix_verb)
              @ver
            end
          end
        end
      end

      puts "Before tidying, the preliminary_verb_array is #{@preliminary_verb_array.length}"

      @verb_folder.each do |filename|
        File.open(filename, "r").each do |verb|
          @verb_prefixes_non_reflexive.each do |non_reflexive_prefix|
            verb = verb.strip
            non_reflexive_prefix = non_reflexive_prefix.strip
            non_reflexive_prefix_length = non_reflexive_prefix.length

            if verb[0] == non_reflexive_prefix[0] && verb[0...non_reflexive_prefix_length] == non_reflexive_prefix && !verb[non_reflexive_prefix_length..-1].include?("si")

              stripped_non_reflexive_prefix_verb = verb[non_reflexive_prefix_length..-1]
              puts "core_verb_array before removal = #{@core_verb_array.length}"
              @preliminary_verb_array.push(stripped_non_reflexive_prefix_verb)
              @core_verb_array.delete(verb)
              puts "core_verb_array after removal = #{@core_verb_array.length}"
            end
          end
        end
      end

      # @verb_folder.each do |filename|
      #   File.open(filename, "r").each do |verb|
      #     @verb_prefixes_non_reflexive.each do |non_reflexive_prefix|
      #       @verb_prefixes_reflexive.each do |reflexive_prefix|
      #
      #         verb = verb.strip
      #         non_reflexive_prefix = non_reflexive_prefix.strip
      #         non_reflexive_prefix_length = non_reflexive_prefix.length
      #         reflexive_prefix = reflexive_prefix.strip
      #         reflexive_prefix_length = reflexive_prefix.length
      #
      #
      #         pre_stripped_verb = verb.split(reflexive_prefix).to_s
      #
      #         # puts pre_stripped_verb
      #
      #         restripped_verb = pre_stripped_verb.split(non_reflexive_prefix).to_s
      #
      #         puts restripped_verb
      #
      #       end
      #     end
      #   end
      # end



      tidy_preliminary_verb_array = @preliminary_verb_array.uniq

      puts "This is the tidy_preliminary_verb_array: #{tidy_preliminary_verb_array.length}"

    end
  end
end

testing = Verbalyser::LemmaDatabaseFetcher.new
# testing.fetch_lemma_database
# testing.verb_check
# testing.strip_verbs
testing.shortlist_verbs


# non_reflexive_prefix = non_reflexive_prefix.strip
# non_reflexive_prefix_length = non_reflexive_prefix.length

# puts "The verb #{verb} has a reflexive_prefix #{reflexive_prefix} which is #{reflexive_prefix.length} so the first #{reflexive_prefix.length} letters of the verb are #{verb[0...reflexive_prefix_length]}"
# puts "#{reflexive_prefix_match_counter}"
