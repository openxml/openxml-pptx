require "openxml/has_children"
require "openxml/pptx/elements/shape_tree"

module OpenXml
  module Pptx
    module Elements
      class CommonSlideData < Element
        include HasChildren

        tag :cSld

        attribute :name

        def shape_tree
          @shape_tree ||= ShapeTree.new
        end

        def add_shape(shape)
          shape_tree.add_shape(shape)
        end

        def add_data(data)
          push(data)
        end

        def to_xml(xml)
          push(shape_tree)
          super
        end
      end
    end
  end
end
