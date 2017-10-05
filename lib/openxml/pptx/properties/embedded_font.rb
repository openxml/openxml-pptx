module OpenXml
  module Pptx
    module Properties
      class EmbeddedFont < SimplePropertyContainerProperty
        namespace :p
        tag :embeddedFont

        value_property :font, required: true, default_value: "Calibri"

        property :regular, as: :font_reference_regular
        property :bold, as: :font_reference_bold
        property :italic, as: :font_reference_italic
        property :bold_italic, as: :font_reference_italic

      end
    end
  end
end
