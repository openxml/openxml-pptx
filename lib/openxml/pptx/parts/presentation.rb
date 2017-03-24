require "openxml/elements/notes_size"
require "openxml/elements/slide_size"

module OpenXml
  module Pptx
    module Parts
      class Presentation < OpenXml::Part
        attr_accessor :relationships
        private :relationships=

        def self.defualt_relationships
          @default_relationships ||= []
        end

        def self.relationship(type, target)
          self.defualt_relationships << [type, target]
        end

        relationship("http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme",
                         "theme/themeBasic.xml")

        relationship("http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster",
                         "slideMasters/slideMasterBasic.xml")

        def initialize
          self.relationships = OpenXml::Parts::Rels.new

          self.class.defualt_relationships.each do |type, target|
            add_relationship type, target
          end
        end

        def add_relationship(type, target)
          relationships.add_relationship(type, target)
        end

        def add_to(parent)
          parent.add_part "ppt/presentation.xml", self
          parent.add_part "ppt/_rels/presentation.xml.rels", relationships
          parent.add_override "/ppt/presentation.xml", "application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"
        end

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
