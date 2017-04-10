require "spec_helper"

describe Verbalyser::CooljugatorFetcher do

  let (:raw_html_output) { File.readlines(File.open("spec/fixtures/demo_raw_html_output.html", "r")) }

  let (:nokogiri_text_extract_raw) {File.readlines(File.open("spec/fixtures/demo_nokogiri_text_extract_raw.txt", "r")) }

  let (:nokogiri_text_extract_first_clean) { File.readlines(File.open("spec/fixtures/demo_nokogiri_text_extract_first_clean.txt", "r")) }

  let (:cleaned_verb_list) { File.readlines(File.open("spec/fixtures/demo_verb_list_cleaned.txt", "r")) }

  subject { Verbalyser::CooljugatorFetcher.new }

  # context "uses Cooljutor's complete list of Lithuanian verbs;" do
  #   it "fetches raw data from Cooljugator" do
  #     expect(subject.fetch_raw_html).to eq(raw_html_output)
  #   end
  # end

  context "has retrieved Conjugator's full list of Lithuanian verbs," do

    it "parses the raw html with Nokogiri" do
      # Readlines turns the Nokogiri document into an array
      expect(subject.parse_raw_html_with_nokogiri).to eq(nokogiri_text_extract_raw)
    end

    it "extracts the text from the parsed Nokogiri HTML document" do
      expect(subject.nokogiri_extract_raw_text).to eq(nokogiri_text_extract_first_clean)
    end

    it "cleans the verb list to leave only infinitive verbs" do
      expect(subject.clean_verb_list).to eq(cleaned_verb_list)
    end

  end
end
