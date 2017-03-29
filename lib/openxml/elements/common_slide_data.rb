require "openxml/extract/element"
require "openxml/elements/shape_tree"

module OpenXml
  module Pptx
    module Elements
      class CommonSlideData < OpenXml::Element
        tag :cSld

        attribute :name


        def shape_tree
          ShapeTree.new
        end


        def to_xml(xml)
          xml[namespace].public_send(tag, xml_attributes) {
            shape_tree.to_xml(xml)
          }
        end
      end
    end
  end
end
