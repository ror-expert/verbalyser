require "spec_helper"

describe Verbalyser::EndingsGrouper do

  let (:infinitive_verb_lemma_suffix) {"aktyvuoti"}
  let (:infinitive_verb_without_lemma_suffix) {"gverti"}
  let (:infinitive_verb_reflexive_lemma_suffix) {"darbuotis"}
  let (:infinitive_verb_reflexive_without_lemma_suffix) {"rengtis"}

  let (:infinitive_verb_lemma_suffix_stripped) {"aktyvuo"}
  let (:infinitive_verb_without_lemma_suffix_stripped) {"gver"}
  let (:infinitive_verb_reflexive_lemma_suffix_stripped) {"darbuo"}
  let (:infinitive_verb_reflexive_without_lemma_suffix_stripped) {"reng"}

  let (:isolated_lemma_suffix_standard) {"uo"}
  let (:infinitive_verb_stem_shaved) {"er"}
  let (:isolated_lemma_suffix_reflexive) {"uo"}
  let (:reflexive_verb_stem_shaved) {"eng"}

  let (:file_name_conjugated_verb_from_lemma_suffix) {"uoti_uoja_avo"}
  let (:file_name_conjugated_verb_from_stem_extract) {"erti_ęra_ẽro"}
  let (:file_name_conjugated_reflexive_verb_lemma_suffix) {"uotis_úojasi_ãvosi"}
  let (:file_name_conjugated_reflexive_verb_stem_extract) {"engtis_eñgiasi_eñgėsi"}

  let (:verb_forms_non_reflexive_lemma) {["aktyvuoti", "aktyvuoja", "aktyvavo\n"]}
  let (:verb_forms_non_reflexive_no_lemma) {["gverti", "gvęra", "gvẽro\n"]}
  let (:verb_forms_reflexive_lemma) {["darbuotis", "darbúojasi", "darbãvosi\n"]}
  let (:verb_forms_reflexive_no_lemma) {["rengtis", "reñgiasi", "reñgėsi\n"]}

  let (:a_tilde_stripped) {"a"}
  let (:a_grave_stripped) {"a"}
  let (:a_acute_stripped) {"a"}
  let (:a_tilde_stripped) {"a"}
  let (:a_grave_stripped) {"a"}
  let (:a_acute_stripped) {"a"}
  let (:e_tilde_stripped) {"a"}
  let (:e_grave_stripped) {"a"}
  let (:e_acute_stripped) {"a"}
  let (:e_nosine_tilde_stripped) {"a"}
  let (:e_nosine_grave_stripped) {"a"}
  let (:e_nosine_acute_stripped) {"a"}
  let (:e_dot_tilde_stripped) {"a"}
  let (:e_dot_grave_stripped) {"a"}
  let (:e_dot_acute_stripped) {"a"}
  let (:i_tilde_stripped) {"a"}
  let (:i_grave_stripped) {"a"}
  let (:i_acute_stripped) {"a"}
  let (:i_dot_tilde_stripped) {"a"}
  let (:i_dot_grave_stripped) {"a"}
  let (:i_dot_acute_stripped) {"a"}
  let (:o_tilde_stripped) {"a"}
  let (:o_grave_stripped) {"a"}
  let (:o_acute_stripped) {"a"}
  let (:u_tilde_stripped) {"a"}
  let (:u_grave_stripped) {"a"}
  let (:u_acute_stripped) {"a"}
  let (:u_nosine_tilde_stripped) {"a"}
  let (:u_nosine_grave_stripped) {"a"}
  let (:u_nosine_acute_stripped) {"a"}
  let (:u_macron_tilde_stripped) {"a"}
  let (:u_macron_grave_stripped) {"a"}
  let (:u_macron_acute_stripped) {"a"}

  subject {Verbalyser::EndingsGrouper.new}
  context "Diverse conjugations, checking for reflexivity:" do

    it "identifies whether aktyvuoti is reflexive::" do
      expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_lemma_suffix)).to eq(false)
    end
    it "identifies whether gverti is reflexive:" do
      expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_without_lemma_suffix)).to eq(false)
    end
    it "identifies whether darbuotis reflexive:" do
      expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_reflexive_lemma_suffix)).to eq(true)
    end
    it "identifies whether rengtis reflexive:" do
      expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_reflexive_without_lemma_suffix)).to eq(true)
    end

    context "Reflexivity ascertained:" do
      it "checks for a lemma suffix in aktyvuoti:" do
        expect(subject.check_for_lemma_suffix(infinitive_verb_lemma_suffix_stripped)).to eq(true)
      end
      it "checks for a lemma suffix in gverti:" do
        expect(subject.check_for_lemma_suffix(infinitive_verb_without_lemma_suffix_stripped)).to eq(false)
      end
      it "checks for a lemma suffix in darbuotis:" do
        expect(subject.check_for_lemma_suffix(infinitive_verb_reflexive_lemma_suffix_stripped)).to eq(true)
      end
      it "checks for a lemma suffix in rengtis:" do
        expect(subject.check_for_lemma_suffix(infinitive_verb_reflexive_without_lemma_suffix_stripped)).to eq(false)
      end

      context "Checked for lemma suffix:" do
        it "creates a classificatory file name for aktyvuoti:" do
          expect(subject.create_classificatory_file_name(infinitive_verb_lemma_suffix)).to eq(file_name_conjugated_verb_from_lemma_suffix)
        end
        it "creates a classificatory file name for gverti:" do
          expect(subject.create_classificatory_file_name(infinitive_verb_without_lemma_suffix)).to eq(file_name_conjugated_verb_from_stem_extract)
        end
        # it "creates a classificatory file name for darbuotis:" do
        #   expect(subject.create_classificatory_file_name(infinitive_verb_reflexive_lemma_suffix)).to eq(file_name_conjugated_reflexive_verb_lemma_suffix)
        # end
        # it "creates a classificatory file name for rengtis:" do
        #   expect(subject.create_classificatory_file_name(infinitive_verb_reflexive_without_lemma_suffix)).to eq(file_name_conjugated_reflexive_verb_stem_extract)
        # end
      end

      context "classificatory file name created:" do
        # it "writes the forms of aktyvuoti to a new file:" do
        #   expect(subject.write_verb_forms_to_group_file(infinitive_verb_lemma_suffix)).to eq(verb_forms_non_reflexive_lemma)
        # end
        # it "writes the forms of gverti to a new file:" do
        #   expect(subject.write_verb_forms_to_group_file(infinitive_verb_without_lemma_suffix)).to eq(verb_forms_non_reflexive_no_lemma)
        # end
        # it "writes the forms of darbuotis to a new file:" do
        #   expect(subject.write_verb_forms_to_group_file(infinitive_verb_reflexive_lemma_suffix)).to eq(verb_forms_reflexive_lemma)
        # end
        # it "writes the forms of rengtis to a new file:" do
        #   expect(subject.write_verb_forms_to_group_file(infinitive_verb_reflexive_without_lemma_suffix)).to eq(verb_forms_reflexive_no_lemma)
        # end
      end
    end
  end
  context "Processing verb forms to create a file name" do

    it "strips accents from all characters but leaves diacritics intact" do
      expect(subject.slice_and_scrub_accents("absórbúõja")).to eq("absorbuoja")
    end
    it "strips accents from all characters but leaves diacritics intact" do
      expect(subject.slice_and_scrub_accents("aukójo")).to eq("aukojo")
    end
  end
end
