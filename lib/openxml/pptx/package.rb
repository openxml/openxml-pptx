# frozen_string_literals: true
require "openxml/package"
require "openxml/pptx/parts/presentation"

module OpenXml
  module Pptx
    class Package < OpenXml::Package
      def add_override(part_name, content_type)
        content_types.add_override "/#{part_name}", content_type
      end

      def add_relationship(type, target)
        rels.add_relationship type, target
      end

      def add_slide(slide)
        presentation.add_slide(slide)
      end

      def set_defaults
        super

        presentation.add_to self
      end

      def presentation
        peesentation ||= OpenXml::Pptx::Parts::Presentation.new
      end
    end
  end
end
