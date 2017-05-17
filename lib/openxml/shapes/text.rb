require "openxml/pptx/elements/shape_non_visual"
require "openxml/pptx/elements/text_body"
require "openxml/elements/paragraph"
require "openxml/elements/run"
require "openxml/elements/text"
require "openxml/elements/body_properties"
require "openxml/elements/run_properties"
require "openxml/pptx/elements/shape_properties"
require "openxml/pptx/elements/nonvisual_drawing_properties"
require "openxml/pptx/elements/nonvisual_shape_drawing_properties"
require "openxml/pptx/elements/nonvisual_properties"

module OpenXml
  module Shapes
    class Text
      attr_writer :boolean_properties, :value_properties
      attr_accessor :text_body, :bounds
      private :text_body=, :bounds=

      def initialize(text_body, bounds, *boolean_properties, **value_properties)
        self.text_body = text_body
        self.bounds = bounds
        self.boolean_properties = boolean_properties
        self.value_properties = value_properties
      end

      def add_to(parent)
      end

      def boolean_properties
        @boolean_properties.clone
      end

      def value_properties
        @value_properties.clone
      end

      def to_xml(xml)
        Shape.new.tap { |shape|
          shape << nonvisual_shape_property
          shape << shape_property
          shape << text_body
        }.to_xml(xml)
      end

      def nonvisual_shape_property
        @nonvisual_shape_property ||= OpenXml::Pptx::Elements::ShapeNonVisual.new.tap {|nv_shape_property|
          nv_shape_property << OpenXml::Pptx::Elements::NonvisualDrawingProperties.new.tap { |nvdp|
            nvdp.id = object_id % OpenXml::Pptx::MAX_ID_SIZE
            nvdp.name = "TextBox"
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

      class Shape < OpenXml::Container
        namespace :p
        tag :sp
      end
    end
  end
end
