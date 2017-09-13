require "openxml/pptx/properties/slide_id"

module OpenXml
  module Pptx
    module Properties
      class SlideIdList < OpenXml::Properties::ContainerProperty
        namespace :p
        tag :sldIdLst
        child_class :slide_id

      end
    end
  end
end
