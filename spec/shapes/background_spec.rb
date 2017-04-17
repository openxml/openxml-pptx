require "spec_helper"
require "support/matchers/generate_tag"
require "openxml/shapes/background"

RSpec.describe OpenXml::Shapes::Background do

  describe "with a valid color" do
    let(:color) { "AB0901" }
    subject { described_class.new(color) }

    it do
      expected_output = """
        <p:bg>
          <p:bgPr>
            <a:solidFill>
              <a:srgbClr val='#{color}'/>
            </a:solidFill>
          </p:bgPr>
        </p:bg>
      """

      is_expected.to generate_tag(expected_output)
    end
  end
end
