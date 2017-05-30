require "spec_helper"
require "support/matchers/generate_tag"
require "openxml/shapes/text"
require "openxml/shapes/bounds"

RSpec.describe OpenXml::Shapes::Text do
  let(:bounds) { OpenXml::Shapes::Bounds.new(0, 0, 1465546, 369333)}
  let(:text_body) { TextBody("Hello World") }

  describe "with no formating" do
    subject { described_class.new(text_body, bounds) }

    it do
      expected_output = """
        <p:sp>
          <p:nvSpPr>
            <p:cNvPr id='#{subject.object_id % OpenXml::Pptx::MAX_ID_SIZE}' name='TextBox'/>
            <p:cNvSpPr/>
            <p:nvPr/>
          </p:nvSpPr>
          <p:spPr>
            <a:xfrm>
              <a:off x='0' y='0'/>
              <a:ext cx='1465546' cy='369333'/>
            </a:xfrm>
          </p:spPr>
          <p:txBody>
            <a:bodyPr/>
            <a:p>
              <a:r>
                <a:t>Hello World</a:t>
              </a:r>
            </a:p>
          </p:txBody>
        </p:sp>
      """

      is_expected.to generate_tag(expected_output)
    end
  end
end
