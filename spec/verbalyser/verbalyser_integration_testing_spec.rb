require "spec_helper"
require "remove_accents"

describe Verbalyser::EndingsGrouper do

  let (:adaptuoti) {"uoti_úoja_ãvo".removeaccents}
  let (:adaptuotis) {"uotis_úojasi_ãvosi".removeaccents}
  let (:badyti) {"yti_o_ė".removeaccents}
  let (:rakinti) {"inti_ìna_ìno".removeaccents}
  let (:plaktis) {"tis_asi_ėsi".removeaccents}
  let (:tamsėti) {"ėti_sė́ja_sė́jo".removeaccents}
  let (:adyti) {"yti_o_ė".removeaccents}
  let (:akinti) {"inti_ina_ino".removeaccents}
  let (:cypauti) {"auti_auja_avo".removeaccents}
  let (:cypti) {"ti_ia_ė".removeaccents}
  let (:flirtuoti) {"uoti_úoja_ãvo".removeaccents}

  subject {Verbalyser::EndingsGrouper.new}

  context "Testing for correct filename" do

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("adaptuoti")).to eq(adaptuoti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("adaptuotis")).to eq(adaptuotis)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("badyti")).to eq(badyti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("rakinti")).to eq(rakinti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("plaktis")).to eq(plaktis)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("adyti")).to eq(adyti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("akinti")).to eq(akinti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("cypauti")).to eq(cypauti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("cypti")).to eq(cypti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("flirtuoti")).to eq(flirtuoti)
    end


  end
end
