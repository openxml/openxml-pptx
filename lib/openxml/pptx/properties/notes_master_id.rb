module OpenXml
  module Pptx
    module Properties
      class NotesMasterId < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        namespace :p
        tag :notesMasterId

        with_namespace :r do
          attribute :rid, displays_as: :id, expects: :string, required: true
        end

        property :extension_list

      end
    end
  end
end
