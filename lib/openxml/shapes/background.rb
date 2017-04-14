require "openxml/pptx/elements/background"
require "openxml/pptx/elements/background_properties"

module OpenXml
  module Shapes
    class Background
      attr_accessor :color
      private :color=

      def initialize(color)
        self.color = color
      end

      def add_to(parent)
      end

      def to_xml(xml)
        OpenXml::Pptx::Elements::Background.new.tap { |bg|
          bg << OpenXml::Pptx::Elements::BackgroundProperties.new(color: self.color)
        }.to_xml(xml)
      end
    end
  end
end
