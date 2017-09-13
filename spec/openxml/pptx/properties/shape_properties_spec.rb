require "spec_helper"

describe OpenXml::Pptx::Properties::ShapeProperties do
  include PropertyTestMacros

  it_should_use tag: :spPr, name: "shape_properties"

  it_should_have_properties :transform, :custom_geometry, :preset_geometry,
                            :solid_fill, :gradient_fill, :pattern_fill, :blip_fill,
                            :outline, :effect_list, :effect_dag, :scene_3d, :extension_list
  it_should_have_value_properties :no_fill, :inherit_group_fill

  for_attribute(:bw_mode) do
    %i{ auto black blackGray blackWhite clr gray grayWhite hidden
        invGray ltGray white }.each do |good_value|
      with_value(good_value) do
        it_should_assign_successfully
        it_should_output_expected_xml
      end
    end

    it_should_not_allow_invalid_value
  end
end
