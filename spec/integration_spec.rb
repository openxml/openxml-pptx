require "spec_helper"
require "rspec/matchers"
require "equivalent-xml"
require "openxml/pptx/parts/slide"
require "openxml/shapes/bounds"
require "openxml/shapes/image"
require "openxml/shapes/background"

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
    let(:theme) { OpenXml::Pptx::Parts::Theme.new }
    let(:master) { OpenXml::Pptx::Parts::SlideMaster.new(theme) }
    let(:layout) { OpenXml::Pptx::Parts::SlideLayout.new(master) }
    let(:slide) { OpenXml::Pptx::Parts::Slide.new(layout) }

    before do
      subject.presentation.add_slide(slide)
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
    let(:theme) { OpenXml::Pptx::Parts::Theme.new }
    let(:master) { OpenXml::Pptx::Parts::SlideMaster.new(theme) }
    let(:layout) { OpenXml::Pptx::Parts::SlideLayout.new(master) }
    let(:slide) { OpenXml::Pptx::Parts::Slide.new(layout) }
    let(:background) { OpenXml::Shapes::Background.new("00B050") }

    before do
      slide.set_background(background)
      subject.presentation.add_slide(slide)
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
    let(:theme) { OpenXml::Pptx::Parts::Theme.new }
    let(:master) { OpenXml::Pptx::Parts::SlideMaster.new(theme) }
    let(:layout) { OpenXml::Pptx::Parts::SlideLayout.new(master) }
    let(:slide1) { OpenXml::Pptx::Parts::Slide.new(layout) }
    let(:slide2) { OpenXml::Pptx::Parts::Slide.new(layout) }

    before do
      subject.presentation.add_slide(slide1)
      subject.presentation.add_slide(slide2)
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
    let(:theme) { OpenXml::Pptx::Parts::Theme.new }
    let(:master) { OpenXml::Pptx::Parts::SlideMaster.new(theme) }
    let(:layout1) { OpenXml::Pptx::Parts::SlideLayout.new(master, "1") }
    let(:layout2) { OpenXml::Pptx::Parts::SlideLayout.new(master, "2") }
    let(:slide1) { OpenXml::Pptx::Parts::Slide.new(layout1) }
    let(:slide2) { OpenXml::Pptx::Parts::Slide.new(layout2) }

    before do
      subject.presentation.add_slide(slide1)
      subject.presentation.add_slide(slide2)
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

  context "with a slide with text" do
    let(:theme) { OpenXml::Pptx::Parts::Theme.new }
    let(:master) { OpenXml::Pptx::Parts::SlideMaster.new(theme) }
    let(:layout) { OpenXml::Pptx::Parts::SlideLayout.new(master) }
    let(:slide) { OpenXml::Pptx::Parts::Slide.new(layout) }
    let(:bounds) { OpenXml::Shapes::Bounds.new(0, 0, 1465545, 369332)}
    let(:text) { OpenXml::Shapes::Text.new("Hello World", bounds) }

    before do
      slide.add_shape text
      subject.presentation.add_slide(slide)
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
    let(:theme) { OpenXml::Pptx::Parts::Theme.new }
    let(:master) { OpenXml::Pptx::Parts::SlideMaster.new(theme) }
    let(:layout) { OpenXml::Pptx::Parts::SlideLayout.new(master) }
    let(:slide) { OpenXml::Pptx::Parts::Slide.new(layout) }
    let(:bounds) { OpenXml::Shapes::Bounds.new(0, 0, 1465545, 369332)}
    let(:text) { OpenXml::Shapes::Text.new("Hello World", bounds) }
    let(:bounds2) { OpenXml::Shapes::Bounds.new(87682, 369332, 1377863, 369332)}
    let(:text2) { OpenXml::Shapes::Text.new("Bye World", bounds2) }

    before do
      slide.add_shape text
      slide.add_shape text2
      subject.presentation.add_slide(slide)
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
    let(:theme) { OpenXml::Pptx::Parts::Theme.new }
    let(:master) { OpenXml::Pptx::Parts::SlideMaster.new(theme) }
    let(:layout) { OpenXml::Pptx::Parts::SlideLayout.new(master) }
    let(:slide) { OpenXml::Pptx::Parts::Slide.new(layout) }
    let(:bounds) { OpenXml::Shapes::Bounds.new(0, 0, 1465545, 369332)}
    let(:text) { OpenXml::Shapes::Text.new("Hello World", bounds) }
    let(:bounds2) { OpenXml::Shapes::Bounds.new(5359400, 2692400, 1463040, 1463040)}
    let(:image_path) { Pathname("spec/fixtures/pic_slide/ppt/media/image1.jpg") }
    let(:pic) { OpenXml::Shapes::Image.new(image_path, bounds2) }

    before do
      slide.add_shape text
      slide.add_shape pic
      subject.presentation.add_slide(slide)
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
end
