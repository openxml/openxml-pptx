# frozen_string_literals: true
require "openxml/drawingml/parts/theme"

module OpenXml
  module Pptx
    module Parts
      class Theme < OpenXml::DrawingML::Parts::Theme
        include OpenXml::RelatablePart

        relationship_type "http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme"
        content_type "application/vnd.openxmlformats-officedocument.theme+xml"
        default_path "ppt/theme/theme.xml"

        def relationships_path; end

        # Default theme
        def self.office_theme
          new.tap do |theme|
            theme.theme_name = "Office Theme"
            theme.theme_elements.color_scheme.tap do |scheme|
              scheme.scheme_name = "Office"
              scheme.dark_one.system_color = :windowText
              scheme.dark_one.system_color.last_color = "000000"
              scheme.light_one.system_color = :window
              scheme.light_one.system_color.last_color = "FFFFFF"
              scheme.dark_two.rgb = "44546A"
              scheme.light_two.rgb = "E7E6E6"
              scheme.accent_one.rgb = "4472C4"
              scheme.accent_two.rgb = "ED7D31"
              scheme.accent_three.rgb = "A5A5A5"
              scheme.accent_four.rgb = "FFC000"
              scheme.accent_five.rgb = "5B9BD5"
              scheme.accent_six.rgb = "70AD47"
              scheme.hyperlink.rgb = "0563C1"
              scheme.followed_hyperlink.rgb = "954F72"
            end
            theme.theme_elements.font_scheme.tap do |scheme|
              scheme.scheme_name = "Office"
              scheme.major_font.latin_font = "Calibri Light"
              scheme.major_font.east_asian_font = ""
              scheme.major_font.complex_script_font = ""
              scheme.minor_font.latin_font = "Calibri"
              scheme.minor_font.east_asian_font = ""
              scheme.minor_font.complex_script_font = ""
            end
            theme.theme_elements.format_scheme.tap do |scheme|
              scheme.scheme_name = "Office"
              3.times do
                scheme.fill_style_list << OpenXml::DrawingML::Properties::FillNone.new(true)
                scheme.line_style_list << OpenXml::DrawingML::Properties::Outline.new
                scheme.effect_style_list << OpenXml::DrawingML::Properties::EffectStyle.new.tap(&:effect_list)
                scheme.background_fill_style_list << OpenXml::DrawingML::Properties::FillNone.new(true)
              end
            end
          end
        end

      end
    end
  end
end
