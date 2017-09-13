module OpenXml
  module Pptx
    module Properties
      class NonVisualConnectionShapeProperties < SimplePropertyContainerProperty
        include OpenXml::RenderWhenEmpty
        namespace :p
        tag :nvCxnSpPr

        property :non_visual_drawing_properties, required: true
        property :non_visual_connection_shape_drawing_properties, required: true
        property :non_visual_properties, required: true

      end
    end
  end
end
