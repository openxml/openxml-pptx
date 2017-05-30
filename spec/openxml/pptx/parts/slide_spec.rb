require "spec_helper"
require "rspec/matchers"
require "equivalent-xml"
require "openxml/pptx/parts/slide"
require "openxml/shapes/bounds"

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

    let(:bounds) { OpenXml::Shapes::Bounds.new(0, 0, 1465545, 369332) }
    let(:text) { OpenXml::Shapes::Text.new(TextBody("Hello World"), bounds) }

    before do
      subject.add_shape(text)
    end

    specify do
      expected_xml = Pathname("spec/fixtures/text_slide/ppt/slides/slide1.xml").read
      actual_xml = subject.content
      expect(actual_xml).to be_equivalent_to(expected_xml).ignoring_attr_values("id")
    end
  end

  describe "with 2 texts" do
    let(:bounds) { OpenXml::Shapes::Bounds.new(0, 0, 1465545, 369332) }
    let(:text) { OpenXml::Shapes::Text.new(TextBody("Hello World"), bounds) }
    let(:bounds2) { OpenXml::Shapes::Bounds.new(87682, 369332, 1377863, 369332) }
    let(:text2) { OpenXml::Shapes::Text.new(TextBody("Bye World"), bounds2) }

    before do
      subject.add_shape text
      subject.add_shape text2
    end

    specify do
      expected_xml = Pathname("spec/fixtures/multi_text_slide/ppt/slides/slide1.xml").read
      actual_xml = subject.content
      expect(actual_xml).to be_equivalent_to(expected_xml).ignoring_attr_values("id")
    end
  end
end
