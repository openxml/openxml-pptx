require "spec_helper"

describe OpenXml::Pptx::Properties::NonVisualGroupShapeDrawingProperties do
  include PropertyTestMacros

  it_should_use tag: :cNvGrpSpPr, name: "non_visual_group_shape_drawing_properties"

  it_should_have_properties :group_shape_locks, :extension_list
end
