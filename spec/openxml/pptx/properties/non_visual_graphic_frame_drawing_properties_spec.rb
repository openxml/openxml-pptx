require "spec_helper"

describe OpenXml::Pptx::Properties::NonVisualGraphicFrameDrawingProperties do
  include PropertyTestMacros

  it_should_use tag: :cNvGraphicFramePr, name: "non_visual_graphic_frame_drawing_properties"

  it_should_have_properties :graphic_frame_locks, :extension_list
end
