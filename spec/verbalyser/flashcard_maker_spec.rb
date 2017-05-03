require "spec_helper"

describe Verbalyser::FlashcardMaker do
  let (:aiškinti) {'''[HTML]<font><span style="color:blue">aiškinti</span> = explain <br><span style="color:red">iš</span><span style="color:blue">aiškinti</span> = explain in full <br><span style="color:red">išsi</span><span style="color:blue">aiškinti</span> = explain "out"<br><span style="color:red">pasi</span><span style="color:blue">aiškinti</span> = explain o\s in full<br><span style="color:blue">aiškinti</span><span style="color:red">s</span> (aiškin<span style="color:red">asi</span>, aiškin<span style="color:red">osi</span>) = clarify<br><span style="color:blue">aišk</span><span style="color:red">ėti</span> (aišk<span style="color:red">ė́ja</span>, aišk<span style="color:red">ė́jo</span>) = become clear</font>'''}

  subject {Verbalyser::FlashcardMaker.new}
  context "Generates text for the online flashcard maker http://www.kitzkikz.com/flashcards/index.php" do
    it "generates import text for aiškinti" do
      expect(subject.generate_import_text("aiškinti")).to eq(aiškinti)
    end
  end
end
