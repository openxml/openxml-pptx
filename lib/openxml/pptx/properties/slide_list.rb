require "openxml/pptx/properties/slide_reference"

module OpenXml
  module Pptx
    module Properties
      class SlideList < OpenXml::Properties::ContainerProperty
        namespace :p
        tag :sldLst
        child_class :slide_reference

      end
    end
  end
end
