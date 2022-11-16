# frozen_string_literals: true
require "openxml/package"

module OpenXml
  module Pptx
    class Package < OpenXml::Package
      attr_reader :presentation

      def add_override(part_name, content_type)
        content_types.add_override "/#{part_name}", content_type
      end

      def add_default(extension, type)
        content_types.add_default extension, type
      end

      # EXTRACT: to openxml-package
      def has_part?(part)
        parts.has_value?(part)
      end

      def set_defaults
        super
        @presentation = OpenXml::Pptx::Parts::Presentation.new(parent: self)
        add_part presentation.path.to_s, presentation
        add_part presentation.relationships_path, presentation.relationships
        add_override presentation.path.to_s, presentation.content_type
        rels.add_relationship presentation.relationship_type, presentation.path
      end

    end
  end
end
