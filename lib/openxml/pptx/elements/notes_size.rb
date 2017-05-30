require "openxml/extract/element"

module OpenXml
  module Pptx
    module Elements
      class NotesSize < OpenXml::Element
        tag :notesSz

        attribute :cx
        attribute :cy

        def initialize(cx = 6858000, cy = 9144000)
          super()
          self.cx = cx
          self.cy = cy
        end

      end
    end
  end
end
