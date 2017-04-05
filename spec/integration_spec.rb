require "spec_helper"
require "rspec/matchers"
require "equivalent-xml"
require "openxml/pptx/parts/slide"

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

  def entries_of(package)
    package.parts.keys
  end

  def content_of(package, part_path)
    package.get_part(part_path).to_xml.to_s(debug: true)
  end
end
