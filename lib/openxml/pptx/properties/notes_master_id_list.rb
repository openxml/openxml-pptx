require "openxml/pptx/properties/notes_master_id"

module OpenXml
  module Pptx
    module Properties
      class NotesMasterIdList < OpenXml::Properties::ContainerProperty
        namespace :p
        tag :notesMasterIdLst
        child_class :notes_master_id

      end
    end
  end
end
