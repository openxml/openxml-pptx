module OpenXml
  module Pptx
    module Properties
      class Background < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        namespace :p
        tag :bg

        attribute :bw_mode, one_of: OpenXml::Pptx::ST_BlackWhiteMode

        property_choice do
          property :background_properties
          property :background_reference
        end

      end
    end
  end
end
