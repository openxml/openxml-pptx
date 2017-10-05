module OpenXml
  module Pptx
    module Properties
      class BackgroundReference < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        namespace :p
        tag :bgRef

        attribute :index, displays_as: :idx, expects: :positive_integer, required: true

        property_choice required: true do
          property :component_rgb, klass: OpenXml::DrawingML::Properties::ColorComponentRgb
          value_property :rgb, klass: OpenXml::DrawingML::Properties::ColorHexRgb
          property :hsl, klass: OpenXml::DrawingML::Properties::ColorHsl
          value_property :system_color, klass: OpenXml::DrawingML::Properties::ColorSystemColor
          value_property :scheme_color, klass: OpenXml::DrawingML::Properties::ColorSchemeColor
          value_property :preset_color, klass: OpenXml::DrawingML::Properties::ColorPresetColor
        end

      end
    end
  end
end
