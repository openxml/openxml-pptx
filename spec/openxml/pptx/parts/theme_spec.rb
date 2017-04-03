require "spec_helper"
require "rspec/matchers"
require "equivalent-xml"
require "support/matchers/include_relationship"

RSpec.describe OpenXml::Pptx::Parts::Theme do
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

    specify do
      expected_xml = Pathname("spec/fixtures/empty_slide/ppt/theme/themeBasic.xml").read
      actual_xml = subject.content
      expect(actual_xml).to be_equivalent_to(expected_xml)
    end
  end
end
