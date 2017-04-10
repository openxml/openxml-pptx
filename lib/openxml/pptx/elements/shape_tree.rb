require "openxml/pptx/elements/nonvisual_properties_group_shape"
require "openxml/pptx/elements/group_shape_properties"

module OpenXml
  module Pptx
    module Elements
      class ShapeTree < OpenXml::Element
        namespace :p
        tag :spTree

        def nonvisual_properties_group_shape
          NonvisualPropertiesGroupShape.new
        end

        def group_shape_properties
          GroupShapeProperties.new
        end

        def to_xml(xml)
          xml[namespace].public_send(tag, xml_attributes) do
            nonvisual_properties_group_shape.to_xml(xml)
            group_shape_properties.to_xml(xml)
            shapes.each do |shape|
              shape.to_xml(xml)
            end
          end
        end

        def add_shape(shape)
          self.shapes.push(shape)
        end

        def shapes
          @shapes ||= []
        end
      end
    end
  end
end

