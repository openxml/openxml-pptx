module OpenXml
  module Pptx
    module Properties
      class ShapeGroup < SimplePropertyContainerProperty
        namespace :p
        tag :grpSp

        property :non_visual_group_shape_properties, required: true
        property :group_shape_properties, required: true

        property :shapes, as: :shapes_container

        property :extension_list

      end
    end
  end
end
