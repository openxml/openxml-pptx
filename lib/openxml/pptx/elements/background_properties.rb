require "openxml/elements/rgb_color"
require "openxml/elements/solid_fill"

module OpenXml
  module Pptx
    module Elements
      class BackgroundProperties < OpenXml::Container
        namespace :p
        tag :bgPr

        def initialize(color: nil)
          super()

          self.color = color
        end

        def to_xml(xml)
          super if render?
        end

        private def color=(color)
          return if color.nil?
          self.push(
            OpenXml::Elements::SolidFill.new.tap { |solid_fill|
              solid_fill << OpenXml::Elements::RGBColor.new(color)
            }
          )
        end
      end
    end
  end
end
