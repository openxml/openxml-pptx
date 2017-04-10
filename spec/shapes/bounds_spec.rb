require "spec_helper"
require "support/matchers/generate_tag"
require "openxml/shapes/bounds"

RSpec.describe OpenXml::Shapes::Bounds do
  describe "with good bounds" do
    subject { described_class.new(0, 0, 2, 2) }

    it do
      expected_output = """
        <a:off x='0' y='0'/>
        <a:ext cx='2' cy='2'/>
      """

      is_expected.to generate_tag(expected_output)
    end
  end

  describe "with a bottom bound that is above the top" do
    specify do
      expect{ described_class.new(0, 1, 2, 0) }.to raise_error(OpenXml::Shapes::Bounds::InvalidBoundsError)
    end
  end

  describe "with a bottom bound that is above the top" do
    specify do
      expect{ described_class.new(1, 0, 0, 2) }.to raise_error(OpenXml::Shapes::Bounds::InvalidBoundsError)
    end
  end
end
