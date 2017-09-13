require "openxml/pptx/properties/control"

module OpenXml
  module Pptx
    module Properties
      class ControlList < OpenXml::Properties::ContainerProperty
        namespace :p
        tag :controls
        child_class :control

      end
    end
  end
end
