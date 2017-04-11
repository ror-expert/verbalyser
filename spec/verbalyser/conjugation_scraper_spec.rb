require "spec_helper"

describe Verbalyser::ConjugationScraper do

  let (:demo_verb_list) {%w[rieti rietis rikiuoti vaikščioti]}

  let (:demo_conjugated_list) {File.readlines("spec/fixtures/demo_verb_list_conjugated.txt")}

  subject {Verbalyser::ConjugationScraper.new(demo_verb_list)}

  context "Has a shortlist of un-prefixed verbs;" do
    it "fetches the present-tense-third-person and past-tense-third-person" do
      expect(subject.fetch_conjugations(demo_verb_list)).to eq(demo_conjugated_list)
    end

  end
end
