require "spec_helper"

describe Verbalyser::LemmaMatcher do

  let (:demo_infinitive_verb) {"aktyvuoti"}
  let (:matching_lemma) {["aktyv"]}

  subject {Verbalyser::LemmaMatcher.new}

  context "Examines a shortlisted un-prefixed infinitive verb" do
    it "finds the longest matching lemma" do
      expect(subject.find_longest_matching_lemma(demo_infinitive_verb)).to eq(matching_lemma)
    end
  end

end
