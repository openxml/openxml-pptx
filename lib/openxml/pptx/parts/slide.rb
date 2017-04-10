require "openxml/shapes/text"

module OpenXml
  module Pptx
    module Parts
      class Slide < OpenXml::Part
        attr_reader :layout
        attr_accessor :relationships, :id, :shapes
        private :relationships=, :id=, :shapes=

        LAYOUT_SCHEMA =
          "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"

        def initialize(layout)
          self.relationships = OpenXml::Parts::Rels.new
          self.layout = layout
          self.shapes = []
        end

        private = def layout=(layout)
          @layout = layout
          add_relationship(layout.relationship)
        end

        def add_relationship(relationship)
          relationships.push(relationship)
        end

        def add_to(slide_count, ancestors)
          parent, *rest = ancestors
          parent.add_part rest, "slides/slide#{slide_count}.xml", self
          parent.add_part rest, "slides/_rels/slide#{slide_count}.xml.rels", relationships

          layout.add_to(ancestors)

          parent.add_slide_relationship relationship(slide_count)

          parent.add_override rest, "slides/slide#{slide_count}.xml", "application/vnd.openxmlformats-officedocument.presentationml.slide+xml"

          shapes.each do |shape|
            shape.add_to([self, *ancestors])
          end
        end

        def add_part(ancestors, path, part)
          parent, *rest = ancestors
          parent.add_part rest, path, part
        end

        def add_default(ancestors, extension, type)
          parent, *rest = ancestors
          parent.add_default rest, extension, type
        end

        def common_slide_data
          @common_slide_data ||= OpenXml::Pptx::Elements::CommonSlideData.new
        end

        def relationship(slide_count)
          OpenXml::Elements::Relationship.new(
            "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide",
            "/ppt/slides/slide#{slide_count}.xml")
        end

        def to_xml
          build_standalone_xml do |xml|
            xml.sld(namespaces) do
              xml.parent.namespace = :p
              common_slide_data.to_xml(xml)
            end
          end
        end

        def add_shape(shape)
          shapes.push shape
          common_slide_data.add_shape shape
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
