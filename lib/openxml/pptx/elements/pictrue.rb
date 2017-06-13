module OpenXml
  module Pptx
    module Elements
      class Picture < Element
        include HasChildren

        namespace :p
        tag :pic

      end
    end
  end
end
