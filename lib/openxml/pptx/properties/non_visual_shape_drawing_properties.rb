module OpenXml
  module Pptx
    module Properties
      class NonVisualShapeDrawingProperties < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        include OpenXml::RenderWhenEmpty
        namespace :p
        tag :cNvSpPr

        attribute :is_textbox, displays_as: :txBox, expects: :boolean

        property :shape_locks, klass: OpenXml::DrawingML::Properties::ShapeLocks
        property :extension_list, klass: OpenXml::DrawingML::Properties::ExtensionList

      end
    end
  end
end
