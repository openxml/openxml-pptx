require "openxml/extract/element"

module OpenXml
  module Pptx
    module Elements
      class NotesSize < OpenXml::Element
        tag :notesSz

        attribute :cx
        attribute :cy
      end
    end
  end
end
