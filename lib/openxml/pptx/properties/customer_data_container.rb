require "openxml/pptx/properties/customer_data"

module OpenXml
  module Pptx
    module Properties
      class CustomerDataContainer < TransparentContainerProperty
        child_class :customer_data

      end
    end
  end
end
