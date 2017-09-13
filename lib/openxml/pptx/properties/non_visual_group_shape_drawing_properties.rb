module OpenXml
  module Pptx
    module Properties
      class NonVisualGroupShapeDrawingProperties < SimplePropertyContainerProperty
        include OpenXml::RenderWhenEmpty
        namespace :p
        tag :cNvGrpSpPr

        property :group_shape_locks, klass: OpenXml::DrawingML::Properties::GroupShapeLocks
        property :extension_list, klass: OpenXml::DrawingML::Properties::ExtensionList

      end
    end
  end
end
