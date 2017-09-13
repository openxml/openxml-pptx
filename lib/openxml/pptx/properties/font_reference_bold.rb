require "openxml/pptx/properties/font_reference"

module OpenXml
  module Pptx
    module Properties
      class FontReferenceBold < FontReference
        namespace :p
        tag :bold

      end
    end
  end
end
