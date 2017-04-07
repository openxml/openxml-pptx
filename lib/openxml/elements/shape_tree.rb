require "openxml/elements/nonvisual_properties_group_shape"
require "openxml/elements/group_shape_properties"

module OpenXml
  module Pptx
    module Elements
      class ShapeTree < OpenXml::Element
        namespace :p
        tag :spTree

        attr_accessor :shape
        private :shape=

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
            shape.to_xml(xml) if shape
          end
        end

        def add_shape(shape)
          self.shape = shape
        end
      end
    end
  end
end

