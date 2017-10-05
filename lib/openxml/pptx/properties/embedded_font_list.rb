require "openxml/pptx/properties/embedded_font"

module OpenXml
  module Pptx
    module Properties
      class EmbeddedFontList < OpenXml::Properties::ContainerProperty
        namespace :p
        tag :embeddedFontLst
        child_class :embedded_font

      end
    end
  end
end
