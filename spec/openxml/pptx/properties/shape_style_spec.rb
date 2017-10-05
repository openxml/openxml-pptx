require "spec_helper"

describe OpenXml::Pptx::Properties::ShapeStyle do
  include PropertyTestMacros

  it_should_use tag: :style, name: "shape_style"

  it_should_have_properties :outline_reference, :fill_reference, :effect_reference, :font_reference
end
