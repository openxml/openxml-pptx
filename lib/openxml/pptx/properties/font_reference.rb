module OpenXml
  module Pptx
    module Properties
      class FontReference < OpenXml::Properties::ComplexProperty
        with_namespace :r do
          attribute :rid, displays_as: :id, expects: :string
        end

      end
    end
  end
end
