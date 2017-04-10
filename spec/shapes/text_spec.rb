require "spec_helper"
require "support/matchers/generate_tag"
require "openxml/shapes/text"
require "openxml/shapes/bounds"

RSpec.describe OpenXml::Shapes::Text do
  describe "with 'Hello World' inside" do
    let(:bounds) { OpenXml::Shapes::Bounds.new(0, 0, 1465546, 369333)}
    subject { described_class.new("Hello World", bounds) }

    specify do
      expect(subject.text).to eql("Hello World")
    end

    it do
      expected_output = """
        <p:sp>
          <p:nvSpPr>
            <p:cNvPr id='#{subject.object_id}' name='TextBox 1'/>
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
