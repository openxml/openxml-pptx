require "spec_helper"

describe OpenXml::Pptx::Properties::NonVisualShapeProperties do
  include PropertyTestMacros

  it_should_use tag: :nvSpPr, name: "non_visual_shape_properties"

  it_should_have_properties :non_visual_drawing_properties, :non_visual_shape_drawing_properties,
                            :non_visual_properties
end
