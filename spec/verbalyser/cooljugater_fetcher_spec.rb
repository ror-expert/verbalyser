require "spec_helper"

describe Verbalyser::CooljugatorFetcher do
  let (:raw_html_output_file) { File.open("output/raw_output.html", "r") }
  let (:raw_html_output) { File.readlines(raw_html_output_file) }

  # let (:parsed_nokogiri_content) { File.readlines(File.open("spec/fixtures/demo_nokogiri_content.txt", "r")) }
  #
  # let (:nokogiri_text_extract_raw_demo) { File.readlines(File.open("spec/fixtures/demo_nokogiri_text_extract_raw.txt", "r")) }
  let (:parsed_nokogiri_content) { File.readlines(File.open("output/nokogiri_output.txt", "r")) }

  subject { Verbalyser::CooljugatorFetcher.new }

  context "uses Cooljutor's complete list of Lithuanian verbs" do
    it "fetches raw data from Cooljugator" do
      expect(subject.fetch_raw_html).to eq(raw_html_output)
    end
  end

  context "has retrieved Conjugator's full list of Lithuanian verbs," do

    it "parses the raw data with Nokogiri" do
      # Readlines turns the Nokogiri document into an array
      expect(subject.parse_raw_html_with_nokogiri).to eq(parsed_nokogiri_content.to_a)
    end

    # it "extracts the text from the parsed Nokogiri HTML document" do
    #   expect(subject.nokogiri_extract_raw_text).to eq(nokogiri_text_extract_raw_demo)
    #
    # end
  end
end
