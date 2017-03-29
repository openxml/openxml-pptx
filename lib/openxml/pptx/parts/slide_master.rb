# frozen_string_literals: true
require "openxml/elements/notes_size"
require "openxml/elements/slide_size"
require "openxml/elements/common_slide_data"
require "openxml/elements/color_map"
require "openxml/elements/slide_layout_list"

module OpenXml
  module Pptx
    module Parts
      class SlideMaster < OpenXml::Part
        attr_accessor :relationships
        private :relationships=

        def self.defualt_relationships
          @default_relationships ||= {}
        end

        def self.relationship(type, target)
          self.defualt_relationships.store(type, target)
        end

        relationship("http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme",
                     "../theme/themeBasic.xml")


        LAYOUT_SCHEMA =
          "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"
        relationship(LAYOUT_SCHEMA,
                     "../slideLayouts/slideLayoutBasic.xml")

        def initialize
          self.relationships = OpenXml::Parts::Rels.new

          self.class.defualt_relationships.each_pair do |type, target|
            add_relationship type, target
          end
        end

        def add_relationship(type, target)
          relationships.add_relationship(type, target)
        end

        def add_to(ancestors)
          parent, *rest = ancestors
          parent.add_part rest, "slideMasters/slideMasterBasic.xml", self
          parent.add_part rest, "slideMasters/_rels/slideMasterBasic.xml.rels", relationships
          parent.add_override rest, "slideMasters/slideMasterBasic.xml", "application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml"

          parent.add_relationship "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster", "slideMasters/slideMasterBasic.xml"
        end

        def common_slide_data
          OpenXml::Pptx::Elements::CommonSlideData.new
        end

        def slide_layout_list
          OpenXml::Pptx::Elements::SlideLayoutList.new.tap { |slide_layout_list|
            relationships.find_all { |relationship|
              relationship.type == LAYOUT_SCHEMA
            }.each do |layout_relationship|
              slide_layout_list.add_layout layout_relationship
            end
          }
        end

        def color_map
          OpenXml::Pptx::Elements::ColorMap.new.tap { |color_map|
            color_map.bg1 = "lt1"
            color_map.tx1 = "dk1"
            color_map.bg2 = "lt2"
            color_map.tx2 = "dk2"
            color_map.accent1 = "accent1"
            color_map.accent2 = "accent2"
            color_map.accent3 = "accent3"
            color_map.accent4 = "accent4"
            color_map.accent5 = "accent5"
            color_map.accent6 = "accent6"
            color_map.hlink = "hlink"
            color_map.folHlink = "folHlink"
          }
        end

        def to_xml
          build_standalone_xml do |xml|
            xml.sldMaster(namespaces) do
              xml.parent.namespace = :p
              common_slide_data.to_xml(xml)
              color_map.to_xml(xml)
              slide_layout_list.to_xml(xml)
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
