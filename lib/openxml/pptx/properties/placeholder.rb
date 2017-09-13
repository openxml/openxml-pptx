module OpenXml
  module Pptx
    module Properties
      class Placeholder < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        namespace :p
        tag :ph

        attribute :type, one_of: OpenXml::Pptx::ST_PlaceholderType
        attribute :orientation, one_of: OpenXml::Pptx::ST_Direction
        attribute :size, one_of: OpenXml::Pptx::ST_PlaceholderSize
        attribute :index, displays_as: :idx, expects: :positive_integer
        attribute :has_custom_prompt, displays_as: :hasCustomPrompt, expects: :boolean

        property :extension_list

      end
    end
  end
end
