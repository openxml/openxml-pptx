require "openxml/pptx/elements/shape_non_visual"
require "openxml/pptx/elements/text_body"
require "openxml/elements/paragraph"
require "openxml/elements/run"
require "openxml/elements/text"
require "openxml/elements/body_properties"
require "openxml/pptx/elements/shape_properties"
require "openxml/pptx/elements/nonvisual_drawing_properties"
require "openxml/pptx/elements/nonvisual_shape_drawing_properties"
require "openxml/pptx/elements/nonvisual_properties"

module OpenXml
  module Shapes
    class Text
      attr_accessor :text, :bounds
      private :text=, :bounds=

      def initialize(text, bounds)
        self.text = text
        self.bounds = bounds
      end

      def nonvisual_shape_property
        @nonvisual_shape_property ||= OpenXml::Pptx::Elements::ShapeNonVisual.new.tap {|nv_shape_property|
          nv_shape_property << OpenXml::Pptx::Elements::NonvisualDrawingProperties.new.tap { |nvdp|
            nvdp.id = object_id
            nvdp.name = "TextBox 1"
          }
          nv_shape_property << OpenXml::Pptx::Elements::NonvisualShapeDrawingProperties.new
          nv_shape_property << OpenXml::Pptx::Elements::NonvisualProperties.new
        }
      end

      def shape_property
        @shape_property = OpenXml::Pptx::Elements::ShapeProperties.new.tap { |sp|
          sp << OpenXml::DrawingML::Elements::TransformEffect.new.tap { |effect|
            effect << bounds
          }
        }
      end

      def text_body
        @text_body ||= OpenXml::Pptx::Elements::TextBody.new.tap { |text_body|
          text_body << OpenXml::Elements::BodyProperties.new
          text_body << OpenXml::Elements::Paragraph.new.tap { |paragraph|
            paragraph << OpenXml::Elements::Run.new.tap { |run|
              run << OpenXml::Elements::Text.new(text)
            }
          }
        }
      end

      def to_xml(xml)
        Shape.new.tap { |shape|
          shape << nonvisual_shape_property
          shape << shape_property
          shape << text_body
        }.to_xml(xml)
      end

      class Shape < OpenXml::Container
        namespace :p
        tag :sp
      end
    end
  end
end
