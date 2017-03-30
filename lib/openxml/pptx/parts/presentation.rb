# frozen_string_literals: true
require "openxml/elements/notes_size"
require "openxml/elements/slide_size"
require "openxml/pptx/parts/slide_master"
require "openxml/pptx/parts/slide_layout"
require "openxml/pptx/parts/theme"
require "openxml/elements/slide_master_list"
require "openxml/elements/slide_id_list"

module OpenXml
  module Pptx
    module Parts
      class Presentation < OpenXml::Part
        attr_accessor :relationships, :layout, :master, :theme, :slides, :masters
        private :relationships=

        def initialize
          self.relationships = OpenXml::Parts::Rels.new
          self.master = OpenXml::Pptx::Parts::SlideMaster.new
          self.layout = OpenXml::Pptx::Parts::SlideLayout.new
          self.theme = OpenXml::Pptx::Parts::Theme.new
          self.slides = OpenXml::Pptx::Elements::SlideIdList.new
          self.masters = OpenXml::Pptx::Elements::SlideMasterList.new
        end

        def add_relationship(type, target)
          relationships.add_relationship(type, target)
        end

        def add_slide(slide)
          slide.add_to [self]
        end

        def add_to(ancestors)
          parent, *rest = ancestors
          parent.add_part "ppt/presentation.xml", self
          parent.add_part "ppt/_rels/presentation.xml.rels", relationships
          parent.add_override "ppt/presentation.xml", "application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"
          parent.add_relationship "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument", "ppt/presentation.xml"

          master.add_to [self, parent, *rest]
          layout.add_to [self, parent, *rest]
          theme.add_to [self, parent, *rest]
        end

        def add_part(ancestors, path, part)
          parent, *rest = ancestors
          parent.add_part "ppt/#{path}", part
        end

        def add_override(ancestors, part_name, content_type)
          parent, *rest = ancestors
          parent.add_override "ppt/#{part_name}", content_type
        end

        def add_master_relationship(type, target)
          relationship = add_relationship(type, target)
          self.masters.add_master(relationship)
        end

        def add_slide_relationship(type, target)
          relationship = add_relationship(type, target)
          self.slides.add_slide(relationship)
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
              masters.to_xml(xml)
              slides.to_xml(xml)
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
