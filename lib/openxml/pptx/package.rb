# frozen_string_literals: true
require "openxml/package"
require "openxml/pptx/parts/presentation"

module OpenXml
  module Pptx
    class Package < OpenXml::Package
      attr_accessor :presentation

      def add_override(part_name, content_type)
        content_types.add_override "/#{part_name}", content_type
      end

      def add_relationship(type, target)
        rels.add_relationship type, target
      end

      def add_presentation(presentation)
        self.presentation = presentation
      end

      def add_slide(slide)
        presentation.add_slide(self, slide)
      end

      def set_defaults
        super
      end
    end
  end
end
