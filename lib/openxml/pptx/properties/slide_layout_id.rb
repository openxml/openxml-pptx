module OpenXml
  module Pptx
    module Properties
      class SlideLayoutId < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        namespace :p
        tag :sldLayoutId

        attribute :id, expects: :integer, in_range: OpenXml::Pptx::MASTER_LAYOUT_ID_RANGE
        attribute :rid, displays_as: :id, namespace: :r, expects: :string, required: true

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
