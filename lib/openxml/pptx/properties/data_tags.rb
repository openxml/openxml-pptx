module OpenXml
  module Pptx
    module Properties
      class DataTags < OpenXml::Properties::ComplexProperty
        namespace :p
        tag :tags

        attribute :rid, displays_as: :id, namespace: :r, expects: :string, required: true

      end
    end
  end
end
