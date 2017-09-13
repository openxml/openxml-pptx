module OpenXml
  module Pptx
    module Properties
      class CustomerData < OpenXml::Properties::ComplexProperty
        namespace :p
        tag :custData

        attribute :rid, displays_as: :id, namespace: :r, expects: :string, required: true

      end
    end
  end
end
