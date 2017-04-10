require "openxml/extract/element"

module OpenXml
  module Pptx
    module Elements
      class SlideSize < OpenXml::Element
        tag :sldSz

        attribute :cx
        attribute :cy
      end
    end
  end
end
