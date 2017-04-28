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

  let (:verb_forms_non_reflexive_with_lemma) {["aktyvuoti", "aktyvuoja", "aktyvavo\n"]}
  let (:verb_forms_non_reflexive_no_lemma) {["gverti", "gvęra", "gvẽro\n"]}
  let (:verb_forms_reflexive_with_lemma) {["darbuotis", "darbúojasi", "darbãvosi\n"]}
  let (:verb_forms_reflexive_no_lemma) {["rengtis", "reñgiasi", "reñgėsi\n"]}

  @lithuanian_letters_with_diacritics_and_accents = {
    "a"=>["\\61", "a"],
    "ã"=>["\\e3", "a"],
    "à"=>["\u00e0", "a"],
    "á"=>["\\e1", "a"],
    "ą"=>["\\105"],
    "ą̀"=>["\\105\u0300", "ą"],
    "ą́"=>["\\105\u0301", "ą"],
    "ą̃"=>["\\105\u0303", "ą"],
    "e"=>["65"],
    "ẽ"=>["1ebd", "e"],
    "è"=>["\u00e8", "e"],
    "é"=>["\u00e9", "e"],
    "ę"=>["\u0119"],
    "ę̀"=>["\u0119\u0300", "ę"],
    "ę́"=>["\u0119\u0301", "ę"],
    "ę̃"=>["\u0119\u0303", "ę"],
    "ė"=>["\u0117"],
    "ė̀"=>["\u0117\u0300", "ė"],
    "ė́"=>["\u0117\u0301", "ė"],
    "ė̃"=>["\u0117\u0303", "ė"],
    "į"=>["\u012f"],
    "į̀"=>["\u012f", "į"],
    "į́"=>["\u012f", "į"],
    "į̃"=>["\u012f", "į"],
    "ì"=>["\\ec", "į"],
    "í"=>["\u00ed", "į"],
    "ĩ"=>["\u0129", "į"],
    "o"=>["\\6f"],
    "ò"=>["\u00f2", "o"],
    "ó"=>["\u00f3", "o"],
    "õ"=>["\u00f5", "o"],
    "u"=>["\\75"],
    "ù"=>["\\00f9", "u"],
    "ú"=>["\\00fa", "u"],
    "ũ"=>["\u0169", "u"],
    "ų"=>["\\173"],
    "ų̀"=>["\\173\u0300", "ų"],
    "ų́"=>["\\173\u0301", "ų"],
    "ų̃"=>["\\173\u0303", "ų"],
    "ū"=>["\\16b"],
    "ū̀"=>["\\16b\u0300", "ū"],
    "ū́"=>["\\16b\u0301", "ū"],
    "ū̃"=>["\\16b\u0303", "ū"],
    "y"=>["\\79"],
    "ỳ"=>["\u1ef3", "y"],
    "ý"=>["\u00fd", "y"],
    "ỹ"=>["\u1ef9", "y"],
    "l"=>["\\6c"],
    "l̀"=>["\\6c\u0300", "l"],
    "ĺ"=>["\u013a", "l"],
    "l̃"=>["\\6c\u0303", "l"],
    "m"=>["\\6d"],
    "m̀"=>["\\6d\u0300", "m"],
    "ḿ"=>["\u1e3f", "m"],
    "m̃"=>["\\6d\u0303", "m"],
    "n"=>["\\6e"],
    "ǹ"=>["\u01f9", "n"],
    "ń"=>["\u0144", "n"],
    "ñ"=>["\u00f1", "n"],
    "r"=>["\\72"],
    "r̀"=>["\\72\u0300", "r"],
    "ŕ"=>["\u0155", "r"],
    "r̃"=>["\\72\u0303", "r"],
  }


  subject {Verbalyser::EndingsGrouper.new}
  context "Checking Unicode details" do
    it "identifies the unicode hex value" do
      expect(subject.get_unicode("a")).to eq("61")
    end


  end
end

# context "Diverse conjugations, checking for reflexivity:" do

  # it "identifies whether aktyvuoti is reflexive::" do
  #   expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_with_lemma_suffix)).to eq(false)
  # end
  # it "identifies whether gverti is reflexive:" do
  #   expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_without_lemma_suffix)).to eq(false)
  # end
  # it "identifies whether darbuotis reflexive:" do
  #   expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_reflexive_with_lemma_suffix)).to eq(true)
  # end
  # it "identifies whether rengtis reflexive:" do
  #   expect(subject.identify_whether_verb_is_reflexive(infinitive_verb_reflexive_without_lemma_suffix)).to eq(true)
  # end
  #
  # context "Reflexivity ascertained:" do
  #   it "checks for a lemma suffix in aktyvuoti:" do
  #     expect(subject.check_for_lemma_suffix(infinitive_verb_with_lemma_suffix_stripped)).to eq(true)
  #   end
  #   it "checks for a lemma suffix in gverti:" do
  #     expect(subject.check_for_lemma_suffix(infinitive_verb_without_lemma_suffix_stripped)).to eq(false)
  #   end
  #   it "checks for a lemma suffix in darbuotis:" do
  #     expect(subject.check_for_lemma_suffix(infinitive_verb_reflexive_with_lemma_suffix_stripped)).to eq(true)
  #   end
  #   it "checks for a lemma suffix in rengtis:" do
  #     expect(subject.check_for_lemma_suffix(infinitive_verb_reflexive_without_lemma_suffix_stripped)).to eq(false)
  #   end
  #
  #   context "Checked for lemma suffix:" do
  #     it "creates a classificatory file name for aktyvuoti:" do
  #         expect(subject.create_classificatory_file_name(infinitive_verb_with_lemma_suffix)).to eq(file_name_conjugated_verb_from_lemma_suffix)
  #     end
  #     it "creates a classificatory file name for gverti:" do
  #       expect(subject.create_classificatory_file_name(infinitive_verb_without_lemma_suffix)).to eq(file_name_conjugated_verb_from_stem_extract)
  #     end
  #     it "creates a classificatory file name for darbuotis:" do
  #       expect(subject.create_classificatory_file_name(infinitive_verb_reflexive_with_lemma_suffix)).to eq(file_name_conjugated_reflexive_verb_with_lemma_suffix)
  #     end
  #     it "creates a classificatory file name for rengtis:" do
  #       expect(subject.create_classificatory_file_name(infinitive_verb_reflexive_without_lemma_suffix)).to eq(file_name_conjugated_reflexive_verb_stem_extract)
  #     end
  #   end
  #
  #     context "classificatory file name created:" do
  #       it "writes the forms of aktyvuoti to a new file:" do
  #         expect(subject.write_verb_forms_to_group_file(infinitive_verb_with_lemma_suffix)).to eq(verb_forms_non_reflexive_with_lemma)
  #       end
  #       it "writes the forms of gverti to a new file:" do
  #         expect(subject.write_verb_forms_to_group_file(infinitive_verb_without_lemma_suffix)).to eq(verb_forms_non_reflexive_no_lemma)
  #       end
  #       it "writes the forms of darbuotis to a new file:" do
  #         expect(subject.write_verb_forms_to_group_file(infinitive_verb_reflexive_with_lemma_suffix)).to eq(verb_forms_reflexive_with_lemma)
  #       end
  #       it "writes the forms of rengtis to a new file:" do
  #         expect(subject.write_verb_forms_to_group_file(infinitive_verb_reflexive_without_lemma_suffix)).to eq(verb_forms_reflexive_no_lemma)
  #       end
  #     end
    # end
  # end
# end
