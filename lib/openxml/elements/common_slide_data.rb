require "openxml/extract/element"
require "openxml/elements/shape_tree"

module OpenXml
  module Pptx
    module Elements
      class CommonSlideData < OpenXml::Element
        tag :cSld

        attribute :name

        def shape_tree
          @shape_tree ||= ShapeTree.new
        end

        def add_shape(shape)
          shape_tree.add_shape(shape)
        end

        def to_xml(xml)
          xml[namespace].public_send(tag, xml_attributes) do
            shape_tree.to_xml(xml)
          end
        end
      end
    end
  end
end
