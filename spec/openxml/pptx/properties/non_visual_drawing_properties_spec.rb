require "spec_helper"

describe OpenXml::Pptx::Properties::NonVisualDrawingProperties do
  include PropertyTestMacros

  it_should_use tag: :cNvPr, name: "non_visual_drawing_properties"

  it_should_have_properties :hyperlink_click, :hyperlink_hover, :extension_list

  %i{ description title object_name }.each do |string_attribute|
    for_attribute(string_attribute) do
      with_value("A String") do
        it_should_assign_successfully
        it_should_output_expected_xml
      end

      it_should_not_allow_invalid_value
    end
  end

  for_attribute(:hidden) do
    it_should_behave_like_a_boolean_attribute
  end

  for_attribute(:id) do
    with_value(100) do
      it_should_assign_successfully
      it_should_output "<p:cNvPr id=\"100\"/>"
    end

    [-100, :invalid].each do |bad_value|
      with_value(bad_value) do
        it_should_raise_an_exception
      end
    end
  end
end
