require "spec_helper"
require "support/matchers/generate_tag"
require "openxml/shapes/image"
require "openxml/shapes/bounds"

RSpec.describe OpenXml::Shapes::Image do
  describe "with an image file" do
    let(:bounds) { OpenXml::Shapes::Bounds.new(0, 0, 1465546, 369333)}
    let(:image_path) { Pathname("spec/fixtures/pic_slide/ppt/media/image1.jpg") }
    subject { described_class.new(image_path, bounds) }

    it do
      expected_output = """
      <p:pic>
        <p:nvPicPr>
          <p:cNvPr id='#{subject.object_id % OpenXml::Pptx::MAX_ID_SIZE}' name='Picture'/>
          <p:cNvPicPr/>
          <p:nvPr/>
        </p:nvPicPr>
        <p:blipFill>
          <a:blip r:embed='#{subject.relationship.id}'/>
        </p:blipFill>
        <p:spPr>
          <a:xfrm>
            <a:off x='0' y='0'/>
            <a:ext cx='1465546' cy='369333'/>
          </a:xfrm>
          <a:prstGeom prst='rect'/>
        </p:spPr>
      </p:pic>
      """

      is_expected.to generate_tag(expected_output)
    end
  end
end
