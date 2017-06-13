module OpenXml
  module Pptx
    module Elements
      class NonVisualPictureProperties < Element
        include HasChildren

        namespace :p
        tag :nvPicPr

      end
    end
  end
end
