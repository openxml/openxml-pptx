module OpenXml
  module Pptx
    module Properties
      class CommonSlideData < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        include OpenXml::RenderWhenEmpty
        namespace :p
        tag :cSld

        attribute :slide_name, displays_as: :name, expects: :string

        property :background
        property :shape_tree, required: true
        property :customer_data_list
        property :control_list
        property :extension_list

      end
    end
  end
end
