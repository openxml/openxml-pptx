module OpenXml
  module Pptx
    module Properties
      class DefaultTextStyle < SimplePropertyContainerProperty
        namespace :p
        tag :defaultTextStyle

        property :default_paragraph_properties, klass: OpenXml::DrawingML::Properties::DefaultParagraphProperties
        property :level1_paragraph_properties, klass: OpenXml::DrawingML::Properties::Level1ParagraphProperties
        property :level2_paragraph_properties, klass: OpenXml::DrawingML::Properties::Level2ParagraphProperties
        property :level3_paragraph_properties, klass: OpenXml::DrawingML::Properties::Level3ParagraphProperties
        property :level4_paragraph_properties, klass: OpenXml::DrawingML::Properties::Level4ParagraphProperties
        property :level5_paragraph_properties, klass: OpenXml::DrawingML::Properties::Level5ParagraphProperties
        property :level6_paragraph_properties, klass: OpenXml::DrawingML::Properties::Level6ParagraphProperties
        property :level7_paragraph_properties, klass: OpenXml::DrawingML::Properties::Level7ParagraphProperties
        property :level8_paragraph_properties, klass: OpenXml::DrawingML::Properties::Level8ParagraphProperties
        property :level9_paragraph_properties, klass: OpenXml::DrawingML::Properties::Level9ParagraphProperties

        property :extension_list

      end
    end
  end
end
