require "openxml/pptx/element"

module OpenXml
  module Pptx
    module Elements
      class SlideSize < OpenXml::Pptx::Element
        tag :sldSz

        attribute :cx
        attribute :cy

        def initialize(cx = 12192000, cy = 6858000)
          super()
          self.cx = cx
          self.cy = cy
        end

      end
    end
  end
end
