require "spec_helper"

describe OpenXml::Pptx::Properties::ShapeGroup do
  include PropertyTestMacros

  it_should_use tag: :grpSp, name: "shape_group"

  it_should_have_properties :non_visual_group_shape_properties, :group_shape_properties,
                            :shapes, :extension_list
end
