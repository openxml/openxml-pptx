module OpenXml
  module Pptx
    module Elements
      class TextBody < Element
        include HasChildren

        namespace :p
        tag :txBody

      end
    end
  end
end
