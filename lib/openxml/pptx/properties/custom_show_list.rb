require "openxml/pptx/properties/custom_show"

module OpenXml
  module Pptx
    module Properties
      class CustomShowList < OpenXml::Properties::ContainerProperty
        namespace :p
        tag :custShowLst
        child_class :custom_show

      end
    end
  end
end
