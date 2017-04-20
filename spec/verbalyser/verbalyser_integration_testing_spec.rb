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

  # Solved by adding missing lemmas to database
  let (:cypauti) {"auti_auja_avo".removeaccents}
  let (:cypti) {"ti_ia_ė".removeaccents}
  let (:flirtuoti) {"uoti_úoja_ãvo".removeaccents}
  let (:pisti) {"ti_a_o".removeaccents}
  let (:žnybti) {"ti_ia_ė".removeaccents}
  let (:žvarbėti) {"ėti_à_ėjo".removeaccents}

  # Added because the file name includes too many characters
  let (:svaidyti) {"yti_o_ė".removeaccents}
  let (:neabejoti) {"oti_ója_ójo".removeaccents}
  let (:nekęsti) {"ęsti_eñčia_entė".removeaccents}
  let (:nebepasikiškiakopūsteliauti) {"auti_auja_avo"}
  let (:abuojėti) {"ėti_ėja_ėjo".removeaccents}
  let (:kolaboruoti) {"uoti_uoja_avo".removeaccents}
  let (:aikčioti) {"oti_oja_ojo"}

  # Added because the file name includes accents not removed by 'remove_accents' gem
  let (:barstyti) {"yti_o_ė".removeaccents}
  let (:audėti) {"ėti_a_ėjo"}
  let (:zyzti) {"yzti_yzia_yzė"}
  let (:būgštauti) {"auti_auja_avo"}

  # Added because the filter isn't catching them
  let (:evakuoti) {"uoti_uoja_avo"}
  let (:pildytis) {"ytis_osi_ėsi"}
  let (:grimzti) {"ti_ta_do"}
  let (:kniaukti) {"ti_ia_ė"}
  let (:siųsti) {"ti_čia_tė"}
  let (:inspiruoti) {"uoti_uoja_avo"}

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

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("pisti")).to eq(pisti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("žnybti")).to eq(žnybti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("žvarbėti")).to eq(žvarbėti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("svaidyti")).to eq(svaidyti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("neabejoti")).to eq(neabejoti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("nekęsti")).to eq(nekęsti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("abuojėti")).to eq(abuojėti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("kolaboruoti")).to eq(kolaboruoti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("barstyti")).to eq(barstyti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("audėti")).to eq(audėti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("būgštauti")).to eq(būgštauti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("evakuoti")).to eq(evakuoti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("pildytis")).to eq(pildytis)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("grimzti")).to eq(grimzti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("kniaukti")).to eq(kniaukti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("siųsti")).to eq(siųsti)
    end

    it "outputs a file name from an infinitive_verb input" do
      expect(subject.create_classificatory_file_name("inspiruoti")).to eq(inspiruoti)
    end

  end
end
