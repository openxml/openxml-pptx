module OpenXml
  module Pptx
    module Properties
      class NonVisualShapeProperties < SimplePropertyContainerProperty
        include OpenXml::RenderWhenEmpty
        namespace :p
        tag :nvSpPr

        property :non_visual_drawing_properties, required: true
        property :non_visual_shape_drawing_properties, required: true
        property :non_visual_properties, required: true

      end
    end
  end
end
