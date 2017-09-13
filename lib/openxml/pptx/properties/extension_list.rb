require "openxml/pptx/properties/extension"

module OpenXml
  module Pptx
    module Properties
      class ExtensionList < OpenXml::Properties::ContainerProperty
        namespace :p
        tag :extLst
        child_class :extension

      end
    end
  end
end
