require "spec_helper"

RSpec::Matchers.define :include_relationship do |type, target|
  match do |object|
    object.relationships.any? { |relationship|
      relationship.type == type && relationship.target = target
    }
  end
end

RSpec.describe OpenXml::Pptx::Parts::Presentation do
  describe "with no added relationships" do
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
