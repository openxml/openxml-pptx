module OpenXml
  module Pptx
    module Properties
      class NonVisualPictureDrawingProperties < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        include OpenXml::RenderWhenEmpty
        namespace :p
        tag :cNvPicPr

        attribute :prefer_relative_resizing, displays_as: :preferRelativeResize, expects: :boolean

        property :picture_locks, klass: OpenXml::DrawingML::Properties::PictureLocks
        property :extension_list, klass: OpenXml::DrawingML::Properties::ExtensionList

      end
    end
  end
end
