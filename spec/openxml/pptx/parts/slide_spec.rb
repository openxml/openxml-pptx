require "spec_helper"
require "rspec/matchers"
require "equivalent-xml"
require "openxml/pptx/parts/slide"

RSpec.describe OpenXml::Pptx::Parts::Slide do
  let(:layout_relationship) { double(:layout_relationship) }
  let(:layout) { double(:layout, relationship: layout_relationship) }
  subject { described_class.new(layout) }

  describe "with a relationship" do
    let(:relationship) { :relationship }

    before do
      subject.add_relationship relationship
    end

    it do
      expect(subject.relationships).to include(relationship)
    end

    specify do
      expected_xml = Pathname("spec/fixtures/empty_slide/ppt/slides/slide1.xml").read
      actual_xml = subject.content
      expect(actual_xml).to be_equivalent_to(expected_xml)
    end
  end

  describe "with text" do
    before do
      subject.add_text("Hello World")
    end

    specify do
      expected_xml = Pathname("spec/fixtures/text_slide/ppt/slides/slide1.xml").read
      actual_xml = subject.content
      expect(actual_xml).to be_equivalent_to(expected_xml).ignoring_attr_values("id")
    end
  end
end
