require "spec_helper"

describe Verbalyser::EndingsGrouper do

  let (:demo_infinitive_verb_with_lemma_suffix) {"aktyvuoti"}
  let (:isolated_lemma_suffix) {"uo"}

  let (:demo_infinitive_verb_without_lemma_suffix) {"gverti"}
  let (:isolated_lemma_without_lemma_suffix) {"gver"}


  let (:demo_infinitive_verb_reflexive) {"rengtis"}
  let (:isolated_lemma_suffix_reflexive) {"reng"}

  let (:conjugated_verb_standard_no_lemma_suffix) {"gverti"}
  let (:file_name_conjugated_verb_standard_no_lemma_suffix) {"erti_ęra_ero"}


  subject {Verbalyser::EndingsGrouper.new}

  context "Receives a set of verbs with diverse conjugations" do

    it "analyses the infinitive form of a standard verb with a stem ending and isolates the lemma suffix" do
      expect(subject.isolate_lemma_suffix(demo_infinitive_verb_with_lemma_suffix)).to eq(isolated_lemma_suffix)
    end

    # Cause of failure is missing item in database
    it "analysis the infinitive form of a standard verb without a stem ending and isolates the lemma" do
      expect(subject.isolate_lemma_suffix(demo_infinitive_verb_without_lemma_suffix)).to eq(isolated_lemma_without_lemma_suffix)
    end

    it "analyses the infinitive form of a reflexive verb and isolates the lemma suffix" do
      expect(subject.isolate_lemma_suffix(demo_infinitive_verb_reflexive)).to eq(isolated_lemma_suffix_reflexive)
    end

    it "creates a classificatory file name on the basis of the three main verb forms" do
      expect(subject.classify_verb_by_forms(conjugated_verb_standard_no_lemma_suffix)).to eq(file_name_conjugated_verb_standard_no_lemma_suffix)
    end




  end
end
