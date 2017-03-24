# frozen_string_literals: true
require "openxml/package"
require "openxml/pptx/parts/presentation"

module OpenXml
  module Pptx
    class Package < OpenXml::Package
      TYPE_THEME = "application/vnd.openxmlformats-officedocument.theme+xml"
      TYPE_SLIDEMASTER = "application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml"
      TYPE_SLIDELAYOUTS = "application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml"

      REL_PRESENTATION = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument"

      content_types do
        override "/ppt/slideMasters/slideMasterBasic.xml", TYPE_SLIDEMASTER
        override "/ppt/theme/themeBasic.xml", TYPE_THEME
        override "/ppt/slideLayouts/slideLayoutBasic.xml", TYPE_SLIDELAYOUTS
      end

      def add_override(part_name, content_type)
        self.content_types.add_override part_name, content_type
      end

      def set_defaults
        rels.add_relationship REL_PRESENTATION, "ppt/presentation.xml"

        presentation = OpenXml::Pptx::Parts::Presentation.new

        presentation.add_to self

        super
      end
    end
  end
end
