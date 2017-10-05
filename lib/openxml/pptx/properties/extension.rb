module OpenXml
  module Pptx
    module Properties
      class Extension < OpenXml::Properties::ComplexProperty
        include HasChildren
        namespace :p
        tag :ext

        attribute :uri, expects: :string

      end
    end
  end
end
