require "openxml/pptx/properties/slide_layout_id"

module OpenXml
  module Pptx
    module Properties
      class SlideLayoutIdList < OpenXml::Properties::ContainerProperty
        namespace :p
        tag :sldLayoutIdLst
        child_class :slide_layout_id

      end
    end
  end
end
