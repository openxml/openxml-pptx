module OpenXml
  module Pptx
    module Properties
      class ContentPart < OpenXml::Properties::ComplexProperty
        namespace :p
        tag :contentPart

        attribute :rid, displays_as: :id, namespace: :r, expects: :string, required: true

      end
    end
  end
end
