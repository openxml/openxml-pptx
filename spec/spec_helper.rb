require "openxml/pptx"
require "openxml-drawingml"

require "support/property_test_macros"
require "support/value_property_test_macros"

def populate_text_body(text_body, with: "")
  text_body.build_required_properties
  text_body << OpenXml::DrawingML::Elements::Paragraph.new.tap do |paragraph|
    paragraph << OpenXml::DrawingML::Elements::Run.new.tap do |run|
      run << OpenXml::DrawingML::Elements::Text.new(with)
    end
  end
end

