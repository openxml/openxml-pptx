# frozen_string_literals: true
require "openxml/package"
require "openxml/pptx/parts/presentation"

module OpenXml
  module Pptx
    class Package < OpenXml::Package
      attr_reader :presentation
      TYPE_PRESENTATION = "application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"
      TYPE_THEME = "application/vnd.openxmlformats-officedocument.theme+xml"
      TYPE_SLIDEMASTER = "application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml"
      TYPE_SLIDELAYOUTS = "application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml"

      REL_PRESENTATION = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument"

      content_types do
        override "/ppt/presentation.xml", TYPE_PRESENTATION
        override "/ppt/slideMasters/slideMasterBasic.xml", TYPE_SLIDEMASTER
        override "/ppt/theme/themeBasic.xml", TYPE_THEME
        override "/ppt/slideLayouts/slideLayoutBasic.xml", TYPE_SLIDELAYOUTS
      end

      def set_defaults
        super
        rels.add_relationship REL_PRESENTATION, "ppt/presentation.xml"

        @presentation = OpenXml::Pptx::Parts::Presentation.new

        add_part "ppt/presentation.xml", presentation
        add_part "ppt/_rels/presentation.xml.rels", presentation.relationships
      end
    end
  end
end
