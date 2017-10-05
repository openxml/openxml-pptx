require "spec_helper"
require "rspec/matchers"
require "equivalent-xml"

RSpec.describe OpenXml::Pptx::Parts::Theme do
  describe "with a relationship" do
    let(:relationship_type) { "a-type" }
    let(:relationship_path) { Pathname.new("ppt/slideMaster/slideMaster1.xml") }
    subject { OpenXml::Pptx::Parts::Theme.office_theme }

    before do
      subject.add_relationship relationship_type, relationship_path
    end

    it do
      expect(subject.relationships.first.type).to eq(relationship_type)
      expect(subject.relationships.first.target.to_s).to eq("../slideMaster/slideMaster1.xml")
    end

    specify do
      expected_xml = Pathname("spec/fixtures/empty_slide/ppt/theme/theme1.xml").read
      actual_xml = subject.content
      expect(actual_xml).to be_equivalent_to(expected_xml)
    end
  end
end
