require "spec_helper"

describe OpenXml::Pptx::Properties::CustomShow do
  include PropertyTestMacros

  it_should_use tag: :custShow, name: "custom_show"

  it_should_have_properties :slide_list, :extension_list

  for_attribute(:id) do
    with_value(100) do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    [-100, "100", :invalid].each do |bad_value|
      with_value(bad_value) do
        it_should_raise_an_exception
      end
    end
  end

  for_attribute(:show_name) do
    with_value("A String") do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    it_should_not_allow_invalid_value
  end
end
