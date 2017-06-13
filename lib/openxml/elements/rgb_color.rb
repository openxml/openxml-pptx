module OpenXml
  module Elements
    class RGBColor < OpenXml::Pptx::Element
      namespace :a
      tag :srgbClr
      name :rgb_color

      attribute :hex, displays_as: :val, expects: :hex_color

      def initialize(color)
        self.hex = color
      end
    end
  end
end
