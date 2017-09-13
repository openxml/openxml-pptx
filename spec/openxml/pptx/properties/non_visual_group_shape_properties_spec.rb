require "spec_helper"

describe OpenXml::Pptx::Properties::NonVisualGroupShapeProperties do
  include PropertyTestMacros

  it_should_use tag: :nvGrpSpPr, name: "non_visual_group_shape_properties"

  it_should_have_properties :non_visual_drawing_properties,
                            :non_visual_group_shape_drawing_properties,
                            :non_visual_properties
end
