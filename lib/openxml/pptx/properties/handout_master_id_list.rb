require "openxml/pptx/properties/handout_master_id"

module OpenXml
  module Pptx
    module Properties
      class HandoutMasterIdList < OpenXml::Properties::ContainerProperty
        namespace :p
        tag :handoutMasterIdLst
        child_class :handout_master_id

      end
    end
  end
end
