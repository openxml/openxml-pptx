module OpenXml
  module Pptx
    module Properties
      class TextStyles < SimplePropertyContainerProperty
        namespace :p
        tag :txStyles

        property :title, as: :text_style_title
        property :body, as: :text_style_body
        property :other, as: :text_style_other

        property :extension_list

      end
    end
  end
end
