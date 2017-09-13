require "spec_helper"

describe OpenXml::Pptx::Properties::CommonSlideData do
  include PropertyTestMacros

  it_should_use tag: :cSld, name: "common_slide_data"

  it_should_have_properties :background, :shape_tree, :customer_data_list,
                            :control_list, :extension_list

  for_attribute(:slide_name) do
    with_value("A String") do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    it_should_not_allow_invalid_value
  end
end
