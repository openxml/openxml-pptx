module OpenXml
  module Pptx
    module Properties
      class NonVisualGraphicFrameProperties < SimplePropertyContainerProperty
        include OpenXml::RenderWhenEmpty
        namespace :p
        tag :nvGraphicFramePr

        property :non_visual_drawing_properties, required: true
        property :non_visual_graphic_frame_drawing_properties, required: true
        property :non_visual_properties, required: true

      end
    end
  end
end
