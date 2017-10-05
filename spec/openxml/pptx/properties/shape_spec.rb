require "spec_helper"

describe OpenXml::Pptx::Properties::Shape do
  include PropertyTestMacros

  it_should_use tag: :sp, name: "shape"

  it_should_have_properties :non_visual_shape_properties, :shape_properties, :style,
                            :text_body, :extension_list

  for_attribute(:use_background_fill) do
    it_should_behave_like_a_boolean_attribute
  end
end
