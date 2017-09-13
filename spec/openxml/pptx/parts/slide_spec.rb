require "spec_helper"
require "rspec/matchers"
require "equivalent-xml"
require "openxml/pptx/parts/slide"

RSpec.describe OpenXml::Pptx::Parts::Slide do
  let(:layout) { double(:layout, relationship_type: "a-layout", path: Pathname.new("ppt/slideLayouts/slideLayout1.xml")) }
  subject { described_class.new }

  describe "with a relationship" do
    before do
      subject.build_required_properties
      subject.add_relationship layout.relationship_type, layout.path
    end

    it do
      expect(subject.relationships.first.type).to eq("a-layout")
      expect(subject.relationships.first.target.to_s).to eq("../slideLayouts/slideLayout1.xml")
    end

    specify do
      expected_xml = Pathname("spec/fixtures/empty_slide/ppt/slides/slide1.xml").read
      actual_xml = subject.content
      expect(actual_xml).to be_equivalent_to(expected_xml).ignoring_attr_values("id")
    end
  end

  describe "with text" do
    let(:shape) { build_shape("Hello World") }

    before do
      subject.build_required_properties
      subject.shapes << shape
    end

    specify do
      expected_xml = Pathname("spec/fixtures/text_slide/ppt/slides/slide1.xml").read
      actual_xml = subject.content
      expect(actual_xml).to be_equivalent_to(expected_xml).ignoring_attr_values("id")
    end
  end

  describe "with 2 texts" do
    let(:shape1) { build_shape("Hello World") }
    let(:shape2) { build_shape("Bye World", x: 87_682, y: 369_332, width: 1_377_863, height: 369_332) }

    before do
      subject.build_required_properties
      subject.shapes << shape1
      subject.shapes << shape2
    end

    specify do
      expected_xml = Pathname("spec/fixtures/multi_text_slide/ppt/slides/slide1.xml").read
      actual_xml = subject.content
      expect(actual_xml).to be_equivalent_to(expected_xml).ignoring_attr_values("id")
    end
  end

  def build_shape(text, options={})
    OpenXml::Pptx::Properties::Shape.new.tap do |shape|
      shape.build_required_properties
      shape.shape_name = options.fetch(:shape_name, "TextBox")
      shape.shape_id = options.fetch(:id, shape.object_id % OpenXml::Pptx::MAX_ID)
      shape.offset.x = options.fetch(:x, 0)
      shape.offset.y = options.fetch(:y, 0)
      shape.extent.cx = options.fetch(:width, 1_465_545)
      shape.extent.cy = options.fetch(:height, 369_332)
      populate_text_body(shape.text_body, with: text)
    end
  end
end
