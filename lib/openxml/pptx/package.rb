# frozen_string_literals: true
require "openxml/package"
require "openxml/pptx/parts/presentation"

module OpenXml
  module Pptx
    class Package < OpenXml::Package
      attr_reader :presentation
      REL_PRESENTATION = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument"
      TYPE_PRESENTATION = "application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"
      REL_THEME = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme"
      REL_SLIDE_MASTERS = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster"

      content_types do
        override "/ppt/presentation.xml", TYPE_PRESENTATION
      end

      def set_defaults
        super
        rels.add_relationship REL_PRESENTATION, "ppt/presentation.xml"

        @presentation = OpenXml::Pptx::Parts::Presentation.new

        presentation.add_relationship REL_THEME, "theme/themBasic.xml"
        presentation.add_relationship REL_SLIDE_MASTERS, "slideMasters/slideMasterBasic.xml"

        add_part "ppt/presentation.xml", presentation
        add_part "ppt/_rels/presentation.xml.rels", presentation.relationships
      end
    end
  end
end
