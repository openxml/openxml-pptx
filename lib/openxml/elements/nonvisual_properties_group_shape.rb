require "openxml/extract/element"
require "openxml/elements/nonvisual_properties"
require "openxml/elements/nonvisual_drawing_properties"
require "openxml/elements/nonvisual_group_shape_drawing_properties"

module OpenXml
  module Pptx
    module Elements
      class NonvisualPropertiesGroupShape < OpenXml::Element
        tag :nvGrpSpPr

        def nonvisual_drawing_properties
          NonvisualDrawingProperties.new.tap { |nonvisual_drawing_properties|
            nonvisual_drawing_properties.id = "1"
            nonvisual_drawing_properties.name = ""
          }
        end

        def nonvisual_group_shape_drawing_properties
          NonvisualGroupShapeDrawingProperties.new
        end

        def nonvisual_properties
          NonvisualProperties.new
        end

        def to_xml(xml)
          xml[namespace].public_send(tag, xml_attributes) do
            nonvisual_drawing_properties.to_xml(xml)
            nonvisual_group_shape_drawing_properties.to_xml(xml)
            nonvisual_properties.to_xml(xml)
          end
        end
      end
    end
  end
end
