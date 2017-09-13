require "spec_helper"

describe OpenXml::Pptx::Properties::Transform do
  include PropertyTestMacros

  it_should_use tag: :xfrm, name: "transform"

  it_should_have_property :offset, :extent

  %i{ flip_horizontal flip_vertical }.each do |boolean_attribute|
    for_attribute(boolean_attribute) do
      it_should_behave_like_a_boolean_attribute
    end
  end

  for_attribute(:rotation) do
    with_value(100) do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    it_should_not_allow_invalid_value
  end
end
