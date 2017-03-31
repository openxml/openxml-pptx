module OpenXml
  module Pptx
    module Parts
      class Slide < OpenXml::Part
        attr_accessor :relationships, :id
        private :relationships=, :id=

        def initialize
          self.relationships = OpenXml::Parts::Rels.new
        end

        def add_to(ancestors)
          parent, *rest = ancestors
          parent.add_part rest, "slides/slide1.xml", self
          parent.add_part rest, "slides/_rels/slide1.xml.rels", relationships

          parent.add_slide_relationship "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide", "slides/slide1.xml"
        end

        def common_slide_data
          OpenXml::Pptx::Elements::CommonSlideData.new
        end

        def to_xml
          build_standalone_xml { |xml|
            xml.sld(namespaces) do
              xml.parent.namespace = :p
              common_slide_data.to_xml(xml)
            end
          }
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
