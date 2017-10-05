module OpenXml
  module Pptx
    module Properties
      class SlideMasterId < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        namespace :p
        tag :sldMasterId

        attribute :id, expects: :integer, in_range: OpenXml::Pptx::MASTER_LAYOUT_ID_RANGE

        with_namespace :r do
          attribute :rid, displays_as: :id, expects: :string, required: true
        end

        property :extension_list

        def initialize(*_args)
          super
          generate_id
        end

        def generate_id
          self.id = OpenXml::Pptx::MASTER_LAYOUT_ID_RANGE.begin + object_id % OpenXml::Pptx::MASTER_LAYOUT_ID_RANGE.begin
        end

      end
    end
  end
end
