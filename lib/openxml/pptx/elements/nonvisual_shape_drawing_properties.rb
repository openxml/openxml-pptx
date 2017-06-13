module OpenXml
  module Pptx
    module Elements
      class NonvisualShapeDrawingProperties < Element
        include HasChildren

        namespace :p
        tag :cNvSpPr

      end
    end
  end
end
