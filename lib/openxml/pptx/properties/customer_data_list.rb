module OpenXml
  module Pptx
    module Properties
      class CustomerDataList < SimplePropertyContainerProperty
        namespace :p
        tag :custDataLst

        property :data, as: :customer_data_container
        property :tags, as: :data_tags

      end
    end
  end
end
