require "openxml/elements/nonvisual_properties_group_shape"
require "openxml/elements/group_shape_properties"

module OpenXml
  module Pptx
    module Elements
      class ShapeTree < OpenXml::Element
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
          end
        end
      end
    end
  end
end

