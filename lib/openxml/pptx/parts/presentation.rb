module OpenXml
  module Pptx

    module Elements
      require "openxml/extract/element"
      class SlideSize < OpenXml::Element
        tag :sldSz

        attribute :cx
        attribute :cy
      end

      class NotesSize < OpenXml::Element
        tag :notesSz

        attribute :cx
        attribute :cy
      end
    end

    module Parts
      class Presentation < OpenXml::Part
        def slide_size
          OpenXml::Pptx::Elements::SlideSize.new.tap do |size|
            size.cx = 12192000
            size.cy = 6858000
          end
        end

        def notes_size
          OpenXml::Pptx::Elements::NotesSize.new.tap do |size|
            size.cx = 6858000
            size.cy = 9144000
          end
        end

        def to_xml
          build_standalone_xml do |xml|
            xml.presentation(namespaces) do
              xml.parent.namespace = :p
              slide_size.to_xml(xml)
              notes_size.to_xml(xml)
            end
          end
        end

        private def namespaces
          {
            "xmlns:a": "http://schemas.openxmlformats.org/drawingml/2006/main",
            "xmlns:r": "http://schemas.openxmlformats.org/officeDocument/2006/relationships",
            "xmlns:p": "http://schemas.openxmlformats.org/presentationml/2006/main"
          }
        end
      end
    end
  end
end
