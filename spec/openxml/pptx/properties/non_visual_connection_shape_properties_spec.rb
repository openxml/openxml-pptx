require "spec_helper"

describe OpenXml::Pptx::Properties::NonVisualConnectionShapeProperties do
  include PropertyTestMacros

  it_should_use tag: :nvCxnSpPr, name: "non_visual_connection_shape_properties"

  it_should_have_properties :non_visual_drawing_properties,
                            :non_visual_connection_shape_drawing_properties,
                            :non_visual_properties
end
