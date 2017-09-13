require "spec_helper"

describe OpenXml::Pptx::Properties::NonVisualPictureProperties do
  include PropertyTestMacros

  it_should_use tag: :nvPicPr, name: "non_visual_picture_properties"

  it_should_have_properties :non_visual_drawing_properties, :non_visual_picture_drawing_properties,
                            :non_visual_properties
end
