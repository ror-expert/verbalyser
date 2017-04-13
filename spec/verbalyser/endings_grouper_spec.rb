require "spec_helper"

describe Verbalyser::EndingsGrouper do

  let (:infinitive_verb_with_lemma_suffix) {"aktyvuoti"}
  let (:infinitive_verb_without_lemma_suffix) {"gverti"}
  let (:infinitive_verb_reflexive_with_lemma_suffix) {"darbuotis"}
  let (:infinitive_verb_reflexive_without_lemma_suffix) {"rengtis"}

  let (:isolated_lemma_suffix_standard) {"uo"}
  let (:infinitive_verb_stem) {"gver"}
  let (:isolated_lemma_suffix_reflexive) {"uo"}
  let (:reflexive_verb_stem) {"reng"}

  let (:file_name_conjugated_verb_from_lemma_suffix) {"uoti_uoja_avo"}
  let (:file_name_conjugated_verb_from_stem_extract) {"erti_ęra_ẽro"}
  let (:file_name_reflexive_verb_with_lemma_suffix) {"uotis_úojasi_ãvosi"}
  let (:file_name_conjugated_reflexiv) {"engtis_eñgiasi_eñgėsi"}



  subject {Verbalyser::EndingsGrouper.new}

  context "Receives a set of verbs with diverse conjugations" do

    it "identifies whether aktyvuoti is reflexive" do
      expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_with_lemma_suffix)).to eq("not_reflexive")
    end

    it "identifies whether gverti is reflexive" do
      expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_without_lemma_suffix)).to eq("not_reflexive")
    end

    it "identifies whether darbuotis reflexive" do
      expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_reflexive_with_lemma_suffix)).to eq("reflexive")
    end


    it "identifies whether rengtis reflexive" do
      expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_reflexive_without_lemma_suffix)).to eq("reflexive")
    end

    context "Verb is non-reflexive" do

      it "checks for a lemma suffix in aktyvuoti" do
        expect(subject.check_for_lemma_suffix(infinitive_verb_with_lemma_suffix)).to eq("lemma_suffix_found")
      end

      it "checks for a lemma suffix in gverti" do
        expect(subject.check_for_lemma_suffix(infinitive_verb_without_lemma_suffix)).to eq("lemma_suffix_found")
      end
    end

    context "Verb is reflexive" do
      it "checks for a lemma suffix in darbuotis" do
        expect(subject.check_for_lemma_suffix(infinitive_verb_reflexive_with_lemma_suffix)).to eq("lemma_suffix_found")
      end

      it "checks for a lemma suffix in rengtis" do
        expect(subject.check_for_lemma_suffix(infinitive_verb_reflexive_without_lemma_suffix)).to eq("lemma_suffix_found")
      end

    end









    # darbuotis, darbúojasi, darbãvosi


    # it "analyses the infinitive form of a standard verb with a stem ending and isolates the lemma suffix" do
    #   expect(subject.isolate_lemma_suffix(infinitive_verb_with_lemma_suffix)).to eq(isolated_lemma_suffix)
    # end
    #
    # # Cause of failure is missing item in database
    # it "analysis the infinitive form of a standard verb without a stem ending and isolates the lemma" do
    #   expect(subject.isolate_lemma_suffix(infinitive_verb_without_lemma_suffix)).to eq(isolated_lemma_without_lemma_suffix)
    # end
    #
    # it "analyses the infinitive form of a reflexive verb and isolates the lemma suffix" do
    #   expect(subject.isolate_lemma_suffix(infinitive_verb_reflexive_without_lemma_suffix)).to eq(reflexive_verb_stem)
    # end
    #
    # it "creates a classificatory file name on the basis of the three main verb forms" do
    #   expect(subject.classify_verb_by_forms(infinitive_verb_with_lemma_suffix)).to eq(file_name_conjugated_verb_with_lemma_suffix)
    # end
    #
    # it "creates a classificatory file name on the basis of the three main verb forms" do
    #   expect(subject.classify_verb_by_forms(infinitive_verb_without_lemma_suffix)).to eq(file_name_infinitive_verb_without_lemma_suffix)
    # end
    #
    # it "creates a classificatory file name on the basis of the three main verb forms" do
    #   expect(subject.classify_verb_by_forms(infinitive_verb_reflexive_without_lemma_suffix)).to eq(file_name_reflexive_verb_stem)
    # end

    # it "appends all three forms to the classificatory file" do
    #   expect(subject.write_verb_forms_to_group_file(infinitive_verb_without_lemma_suffix)).to eq(["gverti,gvęra,gvẽro"])
    # end
  end
end
