require "openxml/pptx"

def TextBody(text)
  OpenXml::Pptx::Elements::TextBody.new.tap { |text_body|
    text_body << OpenXml::Elements::BodyProperties.new
    text_body << OpenXml::Elements::Paragraph.new.tap { |paragraph|
      paragraph << OpenXml::Elements::Run.new.tap { |run|
        run << OpenXml::Elements::Text.new(text)
      }
    }
  }
end
