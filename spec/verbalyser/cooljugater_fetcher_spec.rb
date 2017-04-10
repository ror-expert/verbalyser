require "spec_helper"

describe Verbalyser::CooljugatorFetcher do
  let (:raw_html_output_file) { File.open("output/raw_output.html", "r") }
  let (:raw_html_output) { File.readlines(raw_html_output_file) }

  subject { Verbalyser::CooljugatorFetcher.new }
  context "uses Cooljutor's complete list of Lithuanian verbs" do
    it "fetches raw data from Cooljugator" do
      # expect(subject.fetch_raw_html).to eq(File.readlines(File.open("output/raw_output.html", "r")))
      expect(subject.fetch_raw_html).to eq(raw_html_output)
    end
  end
end
