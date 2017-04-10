module OpenXml
  module Shapes
    class Bounds
      attr_accessor :x, :y, :cx, :cy
      private :x=, :y=, :cx=, :cy=

      InvalidBoundsError = Class.new(StandardError)

      def initialize(x, y, cx, cy)
        fail InvalidBoundsError if y > cy || x > cx
        self.x = x
        self.y = y
        self.cx = cx
        self.cy = cy
      end

      def to_xml(xml)
        OpenXml::DrawingML::Elements::Offset.new.tap { |offset|
          offset.x = x
          offset.y = y
        }.to_xml(xml)
        OpenXml::DrawingML::Elements::Extension.new.tap { |extension|
          extension.x = cx
          extension.y = cy
        }.to_xml(xml)
      end
    end
  end
end
