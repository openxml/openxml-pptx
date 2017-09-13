require "spec_helper"

describe OpenXml::Pptx::Properties::GroupShapeProperties do
  include PropertyTestMacros

  it_should_use tag: :grpSpPr, name: "group_shape_properties"

  it_should_have_properties :transform, :solid_fill, :gradient_fill, :pattern_fill,
                            :blip_fill, :effect_list, :effect_dag, :scene_3d, :extension_list
  it_should_have_value_properties :no_fill, :inherit_group_fill

  for_attribute(:bw_mode) do
    with_value(:white) do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    it_should_not_allow_invalid_value
  end
end
