require "spec_helper"
require "support/matchers/have_part_at"
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
    subject { described_class.new }

    specify do
      expect(subject.content_types).to be_instance_of(OpenXml::Parts::ContentTypes)
    end

    specify do
      expect(entries_of(subject)).to contain_exactly(*entries_of(pptx("minimal")))
    end

    pptx("minimal").parts.each do |part_path, expected_part|
      specify do
        expect(content_of(subject, part_path)).to be_equivalent_to(expected_part.content).ignoring_attr_values("Id")
      end
    end
  end

  def entries_of(package)
    package.parts.keys
  end

  def content_of(package, part_path)
    package.get_part(part_path).content
  end
end
