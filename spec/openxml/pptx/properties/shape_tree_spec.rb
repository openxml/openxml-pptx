require "spec_helper"

describe OpenXml::Pptx::Properties::ShapeTree do
  include PropertyTestMacros

  it_should_use tag: :spTree, name: "shape_tree"

  it_should_have_properties :non_visual_group_shape_properties, :group_shape_properties,
                            :shapes, :extension_list
end
