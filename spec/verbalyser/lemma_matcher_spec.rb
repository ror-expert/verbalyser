require "spec_helper"

describe Verbalyser::LemmaMatcher do

  let (:demo_infinitive_verb) {"aktyvuoti"}
  let (:matching_lemma) { ["aktyv"] }
  # let (:demo_infinitive_verb_set) {["aktyvuoti", "skusti", "šalti"]}
  # let (:matching_lemma_set) { ["aktyv", "skus", "šal"] }

  subject {Verbalyser::LemmaMatcher.new}

  context "Examines a shortlisted un-prefixed infinitive verb" do
    it "finds the longest matching lemma" do
      expect(subject.find_longest_matching_lemma(demo_infinitive_verb)).to eq(matching_lemma)
    end
  end

  # context "Examines a set of un-prefixed infinitive verbs" do
  #   it "finds the longest matching lemma for each verb" do
  #     expect(subject.find_longest_matching_lemma(demo_infinitive_verb_set)).to eq(matching_lemma_set)
  #   end
  # end



end
