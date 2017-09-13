module OpenXml
  module Pptx
    module Properties
      class NonVisualConnectionShapeDrawingProperties < SimplePropertyContainerProperty
        include OpenXml::RenderWhenEmpty
        namespace :p
        tag :cNvCxnSpPr

        property :connection_shape_locks, klass: OpenXml::DrawingML::Properties::ConnectionShapeLocks
        property :connection_start, klass: OpenXml::DrawingML::Properties::ConnectionStart
        property :connection_end, klass: OpenXml::DrawingML::Properties::ConnectionEnd

        property :extension_list, klass: OpenXml::DrawingML::Properties::ExtensionList

      end
    end
  end
end
