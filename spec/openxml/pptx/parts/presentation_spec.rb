require "spec_helper"

RSpec::Matchers.define :include_relationship do |type, target|
  match do |object|
    object.relationships.any? { |relationship|
      relationship.type == type && relationship.target = target
    }
  end
end

RSpec.describe OpenXml::Pptx::Parts::Presentation do
  specify do
    expect(subject.relationships).to_not be_empty
  end

  it do
    is_expected.to include_relationship(
      "http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme",
      "theme/themeBasic.xml")
  end

  it do
    is_expected.to include_relationship(
      "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster",
      "slideMasters/slideMasterBasic.xml")
  end

  specify do
    parent = double(:parent)

    expect(parent).to receive(:add_part).with("ppt/presentation.xml", subject)
    expect(parent).to receive(:add_part).with("ppt/_rels/presentation.xml.rels", subject.relationships)
    expect(parent).to receive(:add_override).with(
      "/ppt/presentation.xml",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"
    )

    subject.add_to parent
  end

  describe "with a relationship" do
    let(:type) { "type" }
    let(:target) { "target" }

    before do
      subject.add_relationship type, target
    end

    it do
      is_expected.to include_relationship(type, target)
    end

    specify do
      expect(described_class.new).to_not include_relationship(type, target)
    end
  end
end
