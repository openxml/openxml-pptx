require "spec_helper"
require "support/matchers/have_part_at"

describe OpenXml::Pptx::Package do
  context "when starting a new package" do
    subject { described_class.new }

    specify do
      expect(subject.content_types).to be_instance_of(OpenXml::Parts::ContentTypes)
    end

    specify do
      expect(entries_of(subject)).to contain_exactly(*entries_of(pptx("minimal")))
    end

    specify do
      aggregate_failures do
        pptx("minimal").parts.each do |part_path, expected_part|
          is_expected.to have_part_at(part_path).with_content(expected_part.content)
        end
      end
    end
  end

  def entries_of(package)
    package.parts.keys
  end

  def pptx(pptx_name)
    pathname = Pathname("spec/fixtures/#{pptx_name}.pptx")
    OpenXml::Pptx::Package.open(pathname.realpath)
  end
end
