module OpenXml
  module Pptx
    module Elements
      class ShapeNonVisual < Element
        include HasChildren

        namespace :p
        tag :nvSpPr

      end
    end
  end
end
