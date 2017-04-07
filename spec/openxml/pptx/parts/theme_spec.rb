require "spec_helper"
require "rspec/matchers"
require "equivalent-xml"

RSpec.describe OpenXml::Pptx::Parts::Theme do
  describe "with a relationship" do
    let(:relationship) { :relationship }

    before do
      subject.add_relationship relationship
    end

    it do
      expect(subject.relationships).to include(relationship)
    end

    specify do
      expected_xml = Pathname("spec/fixtures/empty_slide/ppt/theme/themeBasic.xml").read
      actual_xml = subject.content
      expect(actual_xml).to be_equivalent_to(expected_xml)
    end
  end
end
