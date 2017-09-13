require "spec_helper"

describe OpenXml::Pptx::Properties::NonVisualPictureDrawingProperties do
  include PropertyTestMacros

  it_should_use tag: :cNvPicPr, name: "non_visual_picture_drawing_properties"

  it_should_have_properties :picture_locks, :extension_list

  for_attribute(:prefer_relative_resizing) do
    it_should_behave_like_a_boolean_attribute
  end
end
