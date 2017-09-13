require "spec_helper"

RSpec.describe OpenXml::Pptx::Parts::Presentation do
  let(:subject) { OpenXml::Pptx::Package.new.presentation }

  describe "with a relationship" do
    let(:relationship_type) { "a-type" }
    let(:relationship_path) { Pathname.new("ppt/slideMaster/slideMaster1.xml") }

    before do
      subject.add_relationship relationship_type, relationship_path
    end

    specify do
      expect(subject.relationships.entries.last.type).to eq(relationship_type)
      expect(subject.relationships.entries.last.target.to_s).to eq("slideMaster/slideMaster1.xml")
    end
  end
end
