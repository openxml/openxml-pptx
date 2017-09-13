require "forwardable"

module OpenXml
  module Pptx
    module Properties
      class Shape < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        extend Forwardable
        namespace :p
        tag :sp

        attribute :use_background_fill, displays_as: :useBgFill, expects: :boolean

        property :non_visual_shape_properties, required: true
        property :shape_properties, required: true
        property :style, as: :shape_style
        property :text_body

        property :extension_list

        # Convenience Accessors
        def_delegator :non_visual_shape_properties, :non_visual_drawing_properties
        def_delegator :non_visual_drawing_properties, :object_name, :shape_name
        def_delegator :non_visual_drawing_properties, :object_name=, :shape_name=
        def_delegator :non_visual_drawing_properties, :id, :shape_id
        def_delegator :non_visual_drawing_properties, :id=, :shape_id=
        def_delegator :shape_properties, :transform
        def_delegator :transform, :offset
        def_delegator :transform, :extent

      end
    end
  end
end
