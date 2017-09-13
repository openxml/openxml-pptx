module OpenXml
  module Pptx
    module Properties
      class ConnectionShape < SimplePropertyContainerProperty
        namespace :p
        tag :cxnSp

        property :non_visual_connection_shape_properties, required: true
        property :shape_properties, required: true
        property :shape_style
        property :extension_list

      end
    end
  end
end
