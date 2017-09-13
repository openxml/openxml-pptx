require "spec_helper"

describe OpenXml::Pptx::Properties::NonVisualGraphicFrameProperties do
  include PropertyTestMacros

  it_should_use tag: :nvGraphicFramePr, name: "non_visual_graphic_frame_properties"

  it_should_have_properties :non_visual_drawing_properties,
                            :non_visual_graphic_frame_drawing_properties,
                            :non_visual_properties
end
