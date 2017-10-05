module OpenXml
  module Pptx
    module Properties
      class SlideId < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        namespace :p
        tag :sldId

        attribute :id, expects: :integer, in_range: OpenXml::Pptx::SLIDE_ID_RANGE, required: true

        with_namespace :r do
          attribute :rid, displays_as: :id, expects: :string, required: true
        end

        property :extension_list

        def initialize(*_args)
          super
          generate_id
        end

        def generate_id
          self.id = object_id % OpenXml::Pptx::SLIDE_ID_RANGE.end
        end

      end
    end
  end
end
