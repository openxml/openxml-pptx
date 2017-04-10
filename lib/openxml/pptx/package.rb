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

      def add_default(extension, type)
        content_types.add_default extension, type
      end

      def add_relationship(relationship)
        rels.push relationship
      end

      # EXTRACT: to openxml-package
      def has_part?(part)
        parts.has_value?(part)
      end

      def set_defaults
        super
        self.presentation = OpenXml::Pptx::Parts::Presentation.new(self)
        presentation.add_to(self)
      end
    end
  end
end
