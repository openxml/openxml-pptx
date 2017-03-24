# frozen_string_literals: true
require "openxml/elements/notes_size"
require "openxml/elements/slide_size"

module OpenXml
  module Pptx
    module Parts
      class Theme < OpenXml::Part
        attr_accessor :relationships
        private :relationships=

        def self.defualt_relationships
          @default_relationships ||= []
        end

        def self.relationship(type, target)
          self.defualt_relationships << [type, target]
        end

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
          parent.add_part rest, "theme/themeBasic.xml", self
          parent.add_override rest, "theme/themeBasic.xml", "application/vnd.openxmlformats-officedocument.theme+xml"
        end

        def to_xml
          build_standalone_xml do |xml|
            xml.presentation(namespaces) do
              xml.parent.namespace = :a
            end
          end
        end

        private def namespaces
          {
            "xmlns:a": "http://schemas.openxmlformats.org/drawingml/2006/main",
          }
        end
      end
    end
  end
end
