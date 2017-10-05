require "openxml/pptx/properties/font_reference"

module OpenXml
  module Pptx
    module Properties
      class FontReferenceItalic < FontReference
        namespace :p
        tag :italic

      end
    end
  end
end
