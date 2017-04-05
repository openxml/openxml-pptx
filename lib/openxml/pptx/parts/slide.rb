module OpenXml
  module Pptx
    module Parts
      class Slide < OpenXml::Part
        attr_accessor :relationships, :id, :layout
        private :relationships=, :id=, :layout=

        def self.default_relationships
          @default_relationships ||= {}
        end

        def self.relationship(type, target)
          self.default_relationships.store(type, target)
        end

        LAYOUT_SCHEMA =
          "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"
        relationship(LAYOUT_SCHEMA,
                     "../slideLayouts/slideLayoutBasic.xml")

        def initialize(layout)
          self.relationships = OpenXml::Parts::Rels.new
          self.layout = layout

          self.class.default_relationships.each_pair do |type, target|
            add_relationship type, target
          end
        end

        def add_relationship(type, target)
          relationships.add_relationship(type, target)
        end

        def add_to(slide_count, ancestors)
          parent, *rest = ancestors
          parent.add_part rest, "slides/slide#{slide_count}.xml", self
          parent.add_part rest, "slides/_rels/slide#{slide_count}.xml.rels", relationships

          layout.add_to(ancestors)

          parent.add_slide_relationship "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide", "slides/slide#{slide_count}.xml"
          parent.add_override rest, "slides/slide#{slide_count}.xml", "application/vnd.openxmlformats-officedocument.presentationml.slide+xml"
        end

        def common_slide_data
          OpenXml::Pptx::Elements::CommonSlideData.new
        end

        def to_xml
          build_standalone_xml do |xml|
            xml.sld(namespaces) do
              xml.parent.namespace = :p
              common_slide_data.to_xml(xml)
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
