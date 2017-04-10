require "openxml/extract/element"

module OpenXml
  module Pptx
    module Elements
      class NonvisualDrawingProperties < OpenXml::Element
        tag :cNvPr

        attribute :id
        attribute :name
      end
    end
  end
end
