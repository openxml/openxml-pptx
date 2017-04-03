require "spec_helper"
require "support/matchers/include_relationship"

RSpec.describe OpenXml::Pptx::Parts::Presentation do
  specify do
    parent = double(:parent, add_part: nil, add_override: nil)

    expect(parent).to receive(:add_part).with("ppt/presentation.xml", subject)
    expect(parent).to receive(:add_part).with("ppt/_rels/presentation.xml.rels", subject.relationships)
    expect(parent).to receive(:add_override).with(
      "ppt/presentation.xml",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"
    )
    expect(parent).to receive(:add_relationship).with(
      "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument",
      "ppt/presentation.xml"
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
