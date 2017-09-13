require "spec_helper"

describe OpenXml::Pptx::Properties::Extension do
  include PropertyTestMacros

  it_should_use tag: :ext, name: "extension"

  for_attribute(:uri) do
    with_value("A String") do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    it_should_not_allow_invalid_value
  end
end
