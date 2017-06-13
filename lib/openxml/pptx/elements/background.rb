module OpenXml
  module Pptx
    module Elements
      class Background < Element
        include HasChildren

        namespace :p
        tag :bg

      end
    end
  end
end
