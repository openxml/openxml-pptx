module OpenXml
  module Pptx
    module Properties
      class SlideSize < OpenXml::Properties::ComplexProperty
        namespace :p
        tag :sldSz

        attribute :length, displays_as: :cx, expects: :integer, in_range: OpenXml::Pptx::ST_SlideSizeCoordinate, required: true
        attribute :width, displays_as: :cy, expects: :integer, in_range: OpenXml::Pptx::ST_SlideSizeCoordinate, required: true

        attribute :type, one_of: OpenXml::Pptx::ST_SlideSizeType

      end
    end
  end
end
