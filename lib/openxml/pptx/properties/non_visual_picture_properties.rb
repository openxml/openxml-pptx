module OpenXml
  module Pptx
    module Properties
      class NonVisualPictureProperties < SimplePropertyContainerProperty
        include OpenXml::RenderWhenEmpty
        namespace :p
        tag :nvPicPr

        property :non_visual_drawing_properties, required: true
        property :non_visual_picture_drawing_properties, required: true
        property :non_visual_properties, required: true

      end
    end
  end
end
