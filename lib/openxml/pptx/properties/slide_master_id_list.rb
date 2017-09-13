require "openxml/pptx/properties/slide_master_id"

module OpenXml
  module Pptx
    module Properties
      class SlideMasterIdList < OpenXml::Properties::ContainerProperty
        namespace :p
        tag :sldMasterIdLst
        child_class :slide_master_id

      end
    end
  end
end
