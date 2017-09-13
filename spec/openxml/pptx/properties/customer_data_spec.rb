require "spec_helper"

describe OpenXml::Pptx::Properties::CustomerData do
  include PropertyTestMacros

  it_should_use tag: :custData, name: "customer_data"

  for_attribute(:rid) do
    with_value("rId256") do
      it_should_assign_successfully
      it_should_output "<p:custData r:id=\"rId256\"/>"
    end

    it_should_not_allow_invalid_value
  end
end
