require "spec_helper"

describe OpenXml::Pptx::Properties::NonVisualConnectionShapeDrawingProperties do
  include PropertyTestMacros

  it_should_use tag: :cNvCxnSpPr, name: "non_visual_connection_shape_drawing_properties"

  it_should_have_properties :connection_shape_locks, :connection_start,
                            :connection_end, :extension_list
end
