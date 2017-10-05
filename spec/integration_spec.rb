require "spec_helper"
require "rspec/matchers"
require "equivalent-xml"

describe OpenXml::Pptx::Package do
  def self.pptx(pptx_name)
    pathname = Pathname("spec/fixtures/#{pptx_name}.pptx")
    OpenXml::Pptx::Package.open(pathname.realpath)
  end

  def pptx(pptx_name)
    self.class.pptx(pptx_name)
  end

  context "when starting a new package" do
    specify do
      expect(subject.content_types).to be_instance_of(OpenXml::Parts::ContentTypes)
    end

    specify do
      expect(entries_of(subject)).to contain_exactly(*entries_of(pptx("no_slides")))
    end

    pptx("no_slides").parts.each do |part_path, expected_part|
      specify "part at #{part_path} has proper content" do
        expect(content_of(subject, part_path)).to be_equivalent_to(expected_part.content).ignoring_attr_values("Id")
      end
    end
  end

  context "with a single blank slide" do
    let(:theme) { OpenXml::Pptx::Parts::Theme.office_theme.tap { |theme| subject.presentation.add_theme(theme) } }
    let(:master) { subject.presentation.build_slide_master(theme: theme) }
    let(:layout) { master.build_slide_layout(named: "Basic") }
    let(:slide) { subject.presentation.build_slide(slide_layout: layout) }

    before do
      slide
    end

    specify do
      expect(subject.content_types).to be_instance_of(OpenXml::Parts::ContentTypes)
    end

    specify do
      expect(entries_of(subject)).to contain_exactly(*entries_of(pptx("empty_slide")))
    end

    pptx("empty_slide").parts.each do |part_path, expected_part|
      specify "part at #{part_path} has proper content" do
        expect(content_of(subject, part_path)).to be_equivalent_to(expected_part.content).ignoring_attr_values("Id", "id")
      end
    end
  end

  context "with a single color slide" do
    let(:theme) { OpenXml::Pptx::Parts::Theme.office_theme.tap { |theme| subject.presentation.add_theme(theme) } }
    let(:master) { subject.presentation.build_slide_master(theme: theme) }
    let(:layout) { master.build_slide_layout(named: "Basic") }
    let(:slide) { subject.presentation.build_slide(slide_layout: layout) }

    before do
      slide.background_properties.solid_fill.rgb = "00B050"
    end

    specify do
      expect(subject.content_types).to be_instance_of(OpenXml::Parts::ContentTypes)
    end

    specify do
      expect(entries_of(subject)).to contain_exactly(*entries_of(pptx("bg_slide")))
    end

    pptx("bg_slide").parts.each do |part_path, expected_part|
      specify "part at #{part_path} has proper content" do
        expect(content_of(subject, part_path)).to be_equivalent_to(expected_part.content).ignoring_attr_values("Id", "id")
      end
    end
  end

  context "with two blank slides" do
    let(:theme) { OpenXml::Pptx::Parts::Theme.office_theme.tap { |theme| subject.presentation.add_theme(theme) } }
    let(:master) { subject.presentation.build_slide_master(theme: theme) }
    let(:layout) { master.build_slide_layout(named: "Basic") }
    let(:slide1) { subject.presentation.build_slide(slide_layout: layout) }
    let(:slide2) { subject.presentation.build_slide(slide_layout: layout) }

    before do
      slide1
      slide2
    end

    specify do
      expect(subject.content_types).to be_instance_of(OpenXml::Parts::ContentTypes)
    end

    specify do
      expect(entries_of(subject)).to contain_exactly(*entries_of(pptx("multiple_empty_slides")))
    end

    pptx("multiple_empty_slides").parts.each do |part_path, expected_part|
      specify "part at #{part_path} has proper content" do
        expect(content_of(subject, part_path)).to be_equivalent_to(expected_part.content).ignoring_attr_values("Id", "id")
      end
    end
  end

  context "with two layouts" do
    let(:theme) { OpenXml::Pptx::Parts::Theme.office_theme.tap { |theme| subject.presentation.add_theme(theme) } }
    let(:master) { subject.presentation.build_slide_master(theme: theme) }
    let(:layout1) { master.build_slide_layout(named: "1") }
    let(:layout2) { master.build_slide_layout(named: "2") }
    let(:slide1) { subject.presentation.build_slide(slide_layout: layout1) }
    let(:slide2) { subject.presentation.build_slide(slide_layout: layout2) }

    before do
      slide1
      slide2
    end

    specify do
      expect(subject.content_types).to be_instance_of(OpenXml::Parts::ContentTypes)
    end

    specify do
      expect(entries_of(subject)).to contain_exactly(*entries_of(pptx("multiple_layouts")))
    end

    pptx("multiple_layouts").parts.each do |part_path, expected_part|
      specify "part at #{part_path} has proper content" do
        expect(content_of(subject, part_path)).to be_equivalent_to(expected_part.content).ignoring_attr_values("Id", "id")
      end
    end
  end

  context "with a slide with text and a custom size" do
    let(:theme) { OpenXml::Pptx::Parts::Theme.office_theme.tap { |theme| subject.presentation.add_theme(theme) } }
    let(:master) { subject.presentation.build_slide_master(theme: theme) }
    let(:layout) { master.build_slide_layout(named: "Basic") }
    let(:slide) { subject.presentation.build_slide(slide_layout: layout) }
    let(:text) { build_textbox("Hello World") }

    before do
      slide.shapes << text
      subject.presentation.slide_size.length = 13_004_800
      subject.presentation.slide_size.width = 9_753_600
    end

    specify do
      expect(subject.content_types).to be_instance_of(OpenXml::Parts::ContentTypes)
    end

    specify do
      expect(entries_of(subject)).to contain_exactly(*entries_of(pptx("text_slide_custom_size")))
    end

    pptx("text_slide_custom_size").parts.each do |part_path, expected_part|
      specify "part at #{part_path} has proper content" do
        expect(content_of(subject, part_path)).to be_equivalent_to(expected_part.content).ignoring_attr_values("Id", "id", "name")
      end
    end
  end

  context "with a slide with text" do
    let(:theme) { OpenXml::Pptx::Parts::Theme.office_theme.tap { |theme| subject.presentation.add_theme(theme) } }
    let(:master) { subject.presentation.build_slide_master(theme: theme) }
    let(:layout) { master.build_slide_layout(named: "Basic") }
    let(:slide) { subject.presentation.build_slide(slide_layout: layout) }
    let(:text) { build_textbox("Hello World") }

    before do
      slide.shapes << text
    end

    specify do
      expect(subject.content_types).to be_instance_of(OpenXml::Parts::ContentTypes)
    end

    specify do
      expect(entries_of(subject)).to contain_exactly(*entries_of(pptx("text_slide")))
    end

    pptx("text_slide").parts.each do |part_path, expected_part|
      specify "part at #{part_path} has proper content" do
        expect(content_of(subject, part_path)).to be_equivalent_to(expected_part.content).ignoring_attr_values("Id", "id", "name")
      end
    end
  end

  context "with a slide with two text elements" do
    let(:theme) { OpenXml::Pptx::Parts::Theme.office_theme.tap { |theme| subject.presentation.add_theme(theme) } }
    let(:master) { subject.presentation.build_slide_master(theme: theme) }
    let(:layout) { master.build_slide_layout(named: "Basic") }
    let(:slide) { subject.presentation.build_slide(slide_layout: layout) }
    let(:text) { build_textbox("Hello World") }
    let(:text2) { build_textbox("Bye World", x: 87_682, y: 369_332, width: 1_377_863, height: 369_332) }

    before do
      slide.shapes << text
      slide.shapes << text2
    end

    specify do
      expect(subject.content_types).to be_instance_of(OpenXml::Parts::ContentTypes)
    end

    specify do
      expect(entries_of(subject)).to contain_exactly(*entries_of(pptx("multi_text_slide")))
    end

    pptx("multi_text_slide").parts.each do |part_path, expected_part|
      specify "part at #{part_path} has proper content" do
        expect(content_of(subject, part_path)).to be_equivalent_to(expected_part.content).ignoring_attr_values("Id", "id")
      end
    end
  end

  context "with a slide with an image" do
    let(:theme) { OpenXml::Pptx::Parts::Theme.office_theme.tap { |theme| subject.presentation.add_theme(theme) } }
    let(:master) { subject.presentation.build_slide_master(theme: theme) }
    let(:layout) { master.build_slide_layout(named: "Basic") }
    let(:slide) { subject.presentation.build_slide(slide_layout: layout) }
    let(:text) { build_textbox("Hello World") }
    let(:image_part) { slide.build_image_part("spec/fixtures/pic_slide/ppt/media/image1.jpg") }

    before do
      image_rid = slide.relationships_by_path[image_part.path].id
      image = build_image x: 5359400, y: 2692400, width: 1463040, height: 1463040, rid: image_rid
      slide.shapes << text
      slide.shapes << image
    end

    specify do
      expect(subject.content_types).to be_instance_of(OpenXml::Parts::ContentTypes)
    end

    specify do
      expect(entries_of(subject)).to contain_exactly(*entries_of(pptx("pic_slide")))
    end

    pptx("pic_slide").parts.each do |part_path, expected_part|
      next if Pathname(part_path).extname != ".xml"
      specify "part at #{part_path} has proper content" do
        expect(content_of(subject, part_path)).to be_equivalent_to(expected_part.content).ignoring_attr_values("Id", "id", "embed")
      end
    end
  end

  def entries_of(package)
    package.parts.keys
  end

  def content_of(package, part_path)
    package.get_part(part_path).to_xml.to_s(debug: true)
  end

  def build_textbox(text, options={})
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

  def build_image(options={})
    OpenXml::Pptx::Properties::Picture.new.tap do |picture|
      picture.build_required_properties
      picture.picture_name = options.fetch(:picture_name, "Picture")
      picture.picture_id = options.fetch(:id, picture.object_id % OpenXml::Pptx::MAX_ID)
      picture.offset.x = options.fetch(:x, 0)
      picture.offset.y = options.fetch(:y, 0)
      picture.extent.cx = options.fetch(:width, 1_465_545)
      picture.extent.cy = options.fetch(:height, 369_332)
      picture.shape_properties.preset_geometry.shape = :rect
      picture.blip_fill.blip.embed = options.fetch(:rid)
    end
  end
end
