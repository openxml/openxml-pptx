# frozen_string_literals: true
require "openxml/elements/common_slide_data"

module OpenXml
  module Pptx
    module Parts
      class SlideLayout < OpenXml::Part
        attr_reader :master
        attr_accessor :relationships, :name
        private :relationships=, :name=

        def initialize(master, name = "Basic")
          self.relationships = OpenXml::Parts::Rels.new
          self.name = name
          self.master = master
        end

        private def master=(master)
          @master = master
          add_relationship master.relationship_type, "../#{master.relationship_target}"
          master.add_layout(self)
        end

        def relationship_type
          "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"
        end

        def relationship_target
          "slideLayouts/#{part_name}.xml"
        end

        def add_relationship(type, target)
          relationships.add_relationship(type, target)
        end

        def add_to(ancestors)
          parent, *rest = ancestors

          master.add_to(ancestors)

          parent.add_part rest, "slideLayouts/#{part_name}.xml", self
          parent.add_part rest, "slideLayouts/_rels/#{part_name}.xml.rels", relationships
          parent.add_override rest, "slideLayouts/#{part_name}.xml", "application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml"
        end

        def part_name
          "slideLayout#{name}"
        end

        def common_slide_data
          OpenXml::Pptx::Elements::CommonSlideData.new.tap do |common_slide_data|
            common_slide_data.name = name
          end
        end

        def to_xml
          build_standalone_xml do |xml|
            xml.sldLayout(namespaces) do
              xml.parent.namespace = :p
              common_slide_data.to_xml(xml)
            end
          end
        end

        private def namespaces
          {
            "xmlns:a": "http://schemas.openxmlformats.org/drawingml/2006/main",
            "xmlns:r": "http://schemas.openxmlformats.org/officeDocument/2006/relationships",
            "xmlns:p": "http://schemas.openxmlformats.org/presentationml/2006/main",
            "type": "blank",
            "preserve": "1",
          }
        end
      end
    end
  end
end
