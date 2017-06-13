require "openxml/pptx/element"

module OpenXml
  module Pptx
    module Elements
      class NonvisualDrawingProperties < OpenXml::Pptx::Element
        tag :cNvPr

        attribute :id
        attribute :name
      end
    end
  end
end
