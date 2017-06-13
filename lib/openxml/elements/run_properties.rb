require "openxml/elements/rgb_color"
require "openxml/elements/latin"

module OpenXml
  module Elements
    class RunProperties < Element
      include HasChildren

      namespace :a
      tag :rPr

      attribute :italic, displays_as: :i, expects: :boolean
      attribute :bold, displays_as: :b, expects: :boolean
      attribute :size, displays_as: :sz, in_range: (100..400_000)
      attribute :strike, one_of: %w[sngStrike dblStrike noStrike]
      attribute :underline, displays_as: :u, one_of: %w[
        dash
        dashHeavy
        dashLong
        dashLongHeavy
        dbl
        dotDash
        dotDashHeavy
        dotDotDash
        dotDotDashHeavy
        dotted
        dottedHeavy
        heavy
        none
        sng
        wavy
        wavyDbl
        wavyHeavy
        words
      ]

      def initialize(*boolean_properties, font_color: nil, typeface: nil, **value_properties)
        super()

        self.font_color = font_color
        self.typeface = typeface

        boolean_properties.each do |property|
          public_send("#{property}=", true)
        end

        value_properties.each do |property, value|
          public_send("#{property}=", value)
        end
      end

      def to_xml(xml)
        super if render?
      end

      private def font_color=(color)
        return if color.nil?
        self.push(OpenXml::Elements::RGBColor.new(color))
      end

      private def typeface=(typeface)
        return if typeface.nil?
        self.push(OpenXml::Elements::Latin.new(typeface))
      end

    end
  end
end
