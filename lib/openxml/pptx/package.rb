# frozen_string_literals: true
require "openxml/package"
require "openxml/pptx/parts/presentation"

module OpenXml
  module Pptx
    class Package < OpenXml::Package
      attr_reader :presentation
      REL_PRESENTATION = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument"

      TYPE_PRESENTATION = "application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"

      content_types do
        override "/ppt/presentation.xml", TYPE_PRESENTATION
      end

      def set_defaults
        super
        rels.add_relationship REL_PRESENTATION, "ppt/presentation.xml"

        @presentation = OpenXml::Pptx::Parts::Presentation.new

        add_part "ppt/presentation.xml", presentation
      end
    end
  end
end
