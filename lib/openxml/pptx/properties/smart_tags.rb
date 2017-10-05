module OpenXml
  module Pptx
    module Properties
      class SmartTags < OpenXml::Properties::ComplexProperty
        namespace :p
        tag :smartTags

        with_namespace :r do
          attribute :rid, displays_as: :id, expects: :string, required: true
        end

      end
    end
  end
end
