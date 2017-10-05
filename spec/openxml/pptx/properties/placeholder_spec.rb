require "spec_helper"

describe OpenXml::Pptx::Properties::Placeholder do
  include PropertyTestMacros

  it_should_use tag: :ph, name: "placeholder"

  it_should_have_property :extension_list

  for_attribute(:type) do
    with_value(:title) do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    it_should_not_allow_invalid_value
  end

  for_attribute(:orientation) do
    with_value(:vert) do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    it_should_not_allow_invalid_value
  end

  for_attribute(:size) do
    with_value(:full) do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    it_should_not_allow_invalid_value
  end

  for_attribute(:index) do
    with_value(100) do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    [-100, :invalid].each do |bad_value|
      with_value(bad_value) do
        it_should_raise_an_exception
      end
    end
  end

  for_attribute(:has_custom_prompt) do
    it_should_behave_like_a_boolean_attribute
  end
end
