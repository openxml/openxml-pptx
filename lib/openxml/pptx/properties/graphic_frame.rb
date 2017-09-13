module OpenXml
  module Pptx
    module Properties
      class GraphicFrame < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        namespace :p
        tag :graphicFrame

        attribute :bw_mode, one_of: OpenXml::Pptx::ST_BlackWhiteMode

        property :non_visual_graphic_frame_properties, required: true
        property :transform, required: true
        property :graphic, klass: OpenXml::DrawingML::Properties::Graphic, required: true

        property :extension_list

      end
    end
  end
end
