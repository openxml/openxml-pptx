module OpenXml
  module Pptx
    module Properties
      class NonVisualGraphicFrameDrawingProperties < SimplePropertyContainerProperty
        include OpenXml::RenderWhenEmpty
        namespace :p
        tag :cNvGraphicFramePr

        property :graphic_frame_locks, klass: OpenXml::DrawingML::Properties::GraphicFrameLocks
        property :extension_list, klass: OpenXml::DrawingML::Properties::ExtensionList

      end
    end
  end
end
