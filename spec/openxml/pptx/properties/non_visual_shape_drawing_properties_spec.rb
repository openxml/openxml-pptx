require "spec_helper"

describe OpenXml::Pptx::Properties::NonVisualShapeDrawingProperties do
  include PropertyTestMacros

  it_should_use tag: :cNvSpPr, name: "non_visual_shape_drawing_properties"

  it_should_have_properties :shape_locks, :extension_list

  for_attribute(:is_textbox) do
    it_should_behave_like_a_boolean_attribute
  end
end
