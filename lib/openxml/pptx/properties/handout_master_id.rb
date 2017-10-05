module OpenXml
  module Pptx
    module Properties
      class HandoutMasterId < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        namespace :p
        tag :handoutMasterId

        with_namespace :r do
          attribute :rid, displays_as: :id, expects: :string, required: true
        end

        property :extension_list

      end
    end
  end
end
