module OpenXml
  module Pptx
    module Properties
      class NotesSize < OpenXml::Properties::ComplexProperty
        namespace :p
        tag :notesSz

        attribute :length, displays_as: :cx, expects: :positive_integer, required: true
        attribute :width, displays_as: :cy, expects: :positive_integer, required: true

      end
    end
  end
end
