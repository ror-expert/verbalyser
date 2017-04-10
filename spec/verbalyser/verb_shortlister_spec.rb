require "spec_helper"

describe Verbalyser::VerbShortlister do

  let (:demo_shortlist_core) { File.readlines("spec/fixtures/demo_verb_shortlist_core.txt") }

  subject {Verbalyser::VerbShortlister.new}

  context "has the full list of 4,400 verbs," do

    it "puts non-prefixed verbs into the core shortlist" do
      expect(subject.shortlist_non_prefixed_verbs).to eq(demo_shortlist_core)
    end

  end


end
