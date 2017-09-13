require "spec_helper"

describe OpenXml::Pptx::Properties::BackgroundProperties do
  include PropertyTestMacros

  it_should_use tag: :bgPr, name: "background_properties"

  it_should_have_properties :solid_fill, :gradient_fill, :pattern_fill, :blip_fill,
                            :effect_list, :effect_dag, :extension_list
  it_should_have_value_properties :no_fill, :inherit_group_fill

  for_attribute(:shade_to_title) do
    it_should_behave_like_a_boolean_attribute
  end
end
