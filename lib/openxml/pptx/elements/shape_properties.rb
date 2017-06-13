module OpenXml
  module Pptx
    module Elements
      class ShapeProperties < Element
        include HasChildren

        namespace :p
        tag :spPr

      end
    end
  end
end
