require "spec_helper"

describe OpenXml::Pptx::Properties::Background do
  include PropertyTestMacros

  it_should_use tag: :bg, name: "background"

  it_should_have_properties :background_properties, :background_reference

  for_attribute(:bw_mode) do
    with_value(:white) do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    it_should_not_allow_invalid_value
  end
end
