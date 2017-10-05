require "spec_helper"

describe OpenXml::Pptx::Properties::Picture do
  include PropertyTestMacros

  it_should_use tag: :pic, name: "picture"

  it_should_have_properties :non_visual_picture_properties, :blip_fill, :shape_properties,
                            :shape_style, :extension_list
end
