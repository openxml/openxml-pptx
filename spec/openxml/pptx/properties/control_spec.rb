require "spec_helper"

describe OpenXml::Pptx::Properties::Control do
  include PropertyTestMacros

  it_should_use tag: :control, name: "control"

  it_should_have_properties :extension_list, :picture

  for_attribute(:show_as_icon) do
    it_should_behave_like_a_boolean_attribute
  end

  for_attribute(:control_name) do
    with_value("A String") do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    it_should_not_allow_invalid_value
  end

  for_attribute(:rid) do
    with_value("rId256") do
      it_should_assign_successfully
      it_should_output "<p:control r:id=\"rId256\"/>"
    end

    it_should_not_allow_invalid_value
  end

  %i{ image_width image_height }.each do |coordinate_attribute|
    for_attribute(coordinate_attribute) do
      [100, "5cm", "5.5mm"].each do |good_value|
        with_value(good_value) do
          it_should_assign_successfully
          it_should_output_expected_xml
        end
      end

      [-100, "-5mm", :invalid].each do |bad_value|
        with_value(bad_value) do
          it_should_raise_an_exception
        end
      end
    end
  end
end
