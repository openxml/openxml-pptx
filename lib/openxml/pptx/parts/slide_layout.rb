# frozen_string_literals: true
require "openxml/elements/notes_size"
require "openxml/elements/slide_size"

module OpenXml
  module Pptx
    module Parts
      class SlideLayout < OpenXml::Part
        attr_accessor :relationships
        private :relationships=

        def self.defualt_relationships
          @default_relationships ||= []
        end

        def self.relationship(type, target)
          self.defualt_relationships << [type, target]
        end

        relationship("http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme",
                     "../theme/themeBasic.xml")

        relationship("http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout",
                     "../slideMasters/slideMasterBasic.xml")

        def initialize
          self.relationships = OpenXml::Parts::Rels.new

          self.class.defualt_relationships.each do |type, target|
            add_relationship type, target
          end
        end

        def add_relationship(type, target)
          relationships.add_relationship(type, target)
        end

        def add_to(ancestors)
          parent, *rest = ancestors
          parent.add_part rest, "slideLayouts/slideLayoutBasic.xml", self
          parent.add_part rest, "slideLayouts/_rels/slideLayoutBasic.xml.rels", relationships
          parent.add_override rest, "slideLayouts/slideLayoutBasic.xml", "application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml"
        end

        def to_xml
          build_standalone_xml do |xml|
            xml.presentation(namespaces) do
              xml.parent.namespace = :p
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
