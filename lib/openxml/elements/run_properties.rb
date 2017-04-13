module OpenXml
  module Elements
    class RunProperties < OpenXml::Element
      namespace :a
      tag :rPr

      attribute :italic, displays_as: :i, expects: :boolean
      attribute :bold, displays_as: :b, expects: :boolean
      attribute :size, displays_as: :sz, one_of: (100..400_000).to_a
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

      def initialize(*boolean_properties, **value_properties)
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
    end
  end
end
