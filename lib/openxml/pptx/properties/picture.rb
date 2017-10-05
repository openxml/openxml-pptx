require "forwardable"

module OpenXml
  module Pptx
    module Properties
      class Picture < SimplePropertyContainerProperty
        extend Forwardable
        namespace :p
        tag :pic

        property :non_visual_picture_properties, required: true
        property :blip_fill, required: true
        property :shape_properties, required: true
        property :shape_style
        property :extension_list

        # Convenience Accessors
        def_delegator :non_visual_picture_properties, :non_visual_drawing_properties
        def_delegator :non_visual_drawing_properties, :object_name, :picture_name
        def_delegator :non_visual_drawing_properties, :object_name=, :picture_name=
        def_delegator :non_visual_drawing_properties, :id, :picture_id
        def_delegator :non_visual_drawing_properties, :id=, :picture_id=
        def_delegator :shape_properties, :transform
        def_delegator :transform, :offset
        def_delegator :transform, :extent

      end
    end
  end
end
