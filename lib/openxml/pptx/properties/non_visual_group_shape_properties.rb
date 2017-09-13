module OpenXml
  module Pptx
    module Properties
      class NonVisualGroupShapeProperties < SimplePropertyContainerProperty
        include OpenXml::RenderWhenEmpty
        namespace :p
        tag :nvGrpSpPr

        property :non_visual_drawing_properties, required: true
        property :non_visual_group_shape_drawing_properties, required: true
        property :non_visual_properties, required: true

      end
    end
  end
end
