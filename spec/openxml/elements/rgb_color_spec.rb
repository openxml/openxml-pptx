require "spec_helper"
require "support/matchers/generate_tag"
require "openxml/elements/run_properties"

RSpec.describe OpenXml::Elements::RGBColor do
  context "with string hex value" do
    subject { described_class.new("929292") }

    it do
      is_expected.to generate_tag("<a:srgbClr val='929292'/>")
    end
  end

  context "with a string that isn't valid hex" do
    specify do
      expect{ described_class.new("FGGFFG") }.to raise_error(ArgumentError)
    end
  end
end
