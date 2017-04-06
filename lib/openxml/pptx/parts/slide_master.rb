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
        attr_reader :theme
        attr_accessor :relationships, :layouts
        private :relationships=, :layouts=

        def initialize(theme)
          self.relationships = OpenXml::Parts::Rels.new
          self.theme = theme
          self.layouts = OpenXml::Pptx::Elements::SlideLayoutList.new

        end

        private def theme=(theme)
          @theme = theme
          add_relationship theme.relationship_type,
            theme.relationship_target
        end

        def add_relationship(type, target)
          relationships.add_relationship(type, target)
        end

        def add_to(ancestors)
          parent, *rest = ancestors

          return if parent.has_part?(self)

          parent.add_part rest, "slideMasters/slideMasterBasic.xml", self
          parent.add_part rest, "slideMasters/_rels/slideMasterBasic.xml.rels", relationships
          parent.add_override rest, "slideMasters/slideMasterBasic.xml", "application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml"

          parent.add_master_relationship "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster", "/ppt/slideMasters/slideMasterBasic.xml"

          theme.add_to [parent, *rest]
        end

        def common_slide_data
          OpenXml::Pptx::Elements::CommonSlideData.new
        end

        def slide_layout_list
          @slide_layout_list ||= OpenXml::Pptx::Elements::SlideLayoutList.new
        end

        def add_layout_relationship(type, target)
          relationship = add_relationship(type, target)
          self.slide_layout_list.add_layout(relationship)
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
