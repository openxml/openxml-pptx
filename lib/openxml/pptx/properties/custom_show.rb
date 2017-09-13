module OpenXml
  module Pptx
    module Properties
      class CustomShow < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        namespace :p
        tag :custShow

        attribute :id, expects: :positive_integer, required: true
        attribute :show_name, displays_as: :name, expects: :string, required: true

        property :slide_list, required: true
        property :extension_list

      end
    end
  end
end
