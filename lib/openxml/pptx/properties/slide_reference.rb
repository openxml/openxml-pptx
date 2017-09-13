module OpenXml
  module Pptx
    module Properties
      class SlideReference < OpenXml::Properties::ComplexProperty
        namespace :p
        tag :sld

        with_namespace :r do
          attribute :rid, displays_as: :id, expects: :string, required: true
        end

      end
    end
  end
end
