require "openxml/pptx/properties/shape_group"

module OpenXml
  module Pptx
    module Properties
      class ShapeTree < ShapeGroup
        namespace :p
        tag :spTree

      end
    end
  end
end
