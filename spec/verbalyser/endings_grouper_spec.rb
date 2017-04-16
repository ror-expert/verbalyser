require "spec_helper"

describe Verbalyser::EndingsGrouper do

  let (:infinitive_verb_with_lemma_suffix) {"aktyvuoti"}
  let (:infinitive_verb_without_lemma_suffix) {"gverti"}
  let (:infinitive_verb_reflexive_with_lemma_suffix) {"darbuotis"}
  let (:infinitive_verb_reflexive_without_lemma_suffix) {"rengtis"}

  let (:infinitive_verb_with_lemma_suffix_stripped) {"aktyvuo"}
  let (:infinitive_verb_without_lemma_suffix_stripped) {"gver"}
  let (:infinitive_verb_reflexive_with_lemma_suffix_stripped) {"darbuo"}
  let (:infinitive_verb_reflexive_without_lemma_suffix_stripped) {"reng"}

  let (:isolated_lemma_suffix_standard) {"uo"}
  let (:infinitive_verb_stem_shaved) {"er"}
  let (:isolated_lemma_suffix_reflexive) {"uo"}
  let (:reflexive_verb_stem_shaved) {"eng"}

  let (:file_name_conjugated_verb_from_lemma_suffix) {"uoti_uoja_avo"}
  let (:file_name_conjugated_verb_from_stem_extract) {"erti_ęra_ẽro"}
  let (:file_name_conjugated_reflexive_verb_with_lemma_suffix) {"uotis_úojasi_ãvosi"}
  let (:file_name_conjugated_reflexive_verb_stem_extract) {"engtis_eñgiasi_eñgėsi"}



  subject {Verbalyser::EndingsGrouper.new}

  context "Diverse conjugations, checking for reflexivity" do
    it "identifies whether aktyvuoti is reflexive" do
      expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_with_lemma_suffix)).to eq(false)
    end

    it "identifies whether gverti is reflexive" do
      expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_without_lemma_suffix)).to eq(false)
    end

    it "identifies whether darbuotis reflexive" do
      expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_reflexive_with_lemma_suffix)).to eq(true)
    end

    it "identifies whether rengtis reflexive" do
      expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_reflexive_without_lemma_suffix)).to eq(true)
    end
  end

  context "Reflexive verb, checking for lemma suffix" do
    it "checks for a lemma suffix in darbuotis" do
      expect(subject.check_for_lemma_suffix(infinitive_verb_reflexive_with_lemma_suffix_stripped)).to eq(true)
    end

    it "checks for a lemma suffix in rengtis" do
      expect(subject.check_for_lemma_suffix(infinitive_verb_reflexive_without_lemma_suffix_stripped)).to eq(false)
    end
  end

  context "Non-reflexive verb, checking for lemma suffix" do
    it "checks for a lemma suffix in aktyvuoti" do
      expect(subject.check_for_lemma_suffix(infinitive_verb_with_lemma_suffix_stripped)).to eq(true)
    end

    it "checks for a lemma suffix in gverti" do
      expect(subject.check_for_lemma_suffix(infinitive_verb_without_lemma_suffix_stripped)).to eq(false)
    end
  end

  context "Non-reflexive verb with lemma suffix, classify by forms" do
    it "creates a classificatory file name for aktyvuoti" do
      expect(subject.create_classificatory_file_name(infinitive_verb_with_lemma_suffix)).to eq(file_name_conjugated_verb_from_lemma_suffix)
    end
  end

  context "Non-reflexive verb without lemma suffix, classify by forms" do
    it "creates a classificatory file name for gverti" do
      expect(subject.create_classificatory_file_name(infinitive_verb_without_lemma_suffix)).to eq(file_name_conjugated_verb_from_stem_extract)
    end
  end

  context "Reflexive verb with lemma suffix, classify by forms" do
    it "creates a classificatory file name for darbuotis" do
      expect(subject.create_classificatory_file_name(infinitive_verb_reflexive_with_lemma_suffix)).to eq(file_name_conjugated_reflexive_verb_with_lemma_suffix)
    end
  end

  context "Reflexive verb with lemma suffix, classify by forms" do
    it "creates a classificatory file name for darbuotis" do
      expect(subject.create_classificatory_file_name(infinitive_verb_reflexive_without_lemma_suffix)).to eq(file_name_conjugated_reflexive_verb_stem_extract)
    end
  end


  # let (:infinitive_verb_with_lemma_suffix) {"aktyvuoti"}
  # let (:infinitive_verb_without_lemma_suffix) {"gverti"}
  # let (:infinitive_verb_reflexive_with_lemma_suffix) {"darbuotis"}
  # let (:infinitive_verb_reflexive_without_lemma_suffix) {"rengtis"}



  # let (:file_name_conjugated_verb_from_lemma_suffix) {"uoti_uoja_avo"}
  # let (:file_name_conjugated_verb_from_stem_extract) {"erti_ęra_ẽro"}
  # let (:file_name_conjugated_reflexive_verb_with_lemma_suffix) {"uotis_úojasi_ãvosi"}
  # let (:file_name_conjugated_reflexive_verb_stem_extract) {"engtis_eñgiasi_eñgėsi"}


  # context "Reflexive verb with lemma suffix, classify by forms" do
  #   it "creates a classificatory file name for darbuotis" do
  #
  #   end
  # end
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
