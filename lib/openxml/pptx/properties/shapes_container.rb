require "openxml/pptx/properties/shape"
require "openxml/pptx/properties/shape_group"
require "openxml/pptx/properties/graphic_frame"
require "openxml/pptx/properties/connection_shape"
require "openxml/pptx/properties/picture"
require "openxml/pptx/properties/content_part"

module OpenXml
  module Pptx
    module Properties
      class ShapesContainer < TransparentContainerProperty
        child_classes :shape, :shape_group, :graphic_frame, :connection_shape,
                      :picture, :content_part

      end
    end
  end
end
