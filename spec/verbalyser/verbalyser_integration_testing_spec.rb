require "spec_helper"

describe Verbalyser::EndingsGrouper do

  let (:adaptuoti) {"uoti_úoja_ãvo"}
  let (:adaptuotis) {"uotis_úojasi_ãvosi"}
  let (:badyti) {"yti_o_ė"}
  let (:rakinti) {"inti_ìna_ìno"}
  let (:plaktis) {"aktis_ãkasi_ãkėsi"}
  let (:tamsėti) {"ėti_sė́ja_sė́jo"}
  let (:adyti) {"yti_o_ė"}

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



  end
end
