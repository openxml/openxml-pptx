require "spec_helper"

describe OpenXml::Pptx::Properties::ConnectionShape do
  include PropertyTestMacros

  it_should_use tag: :cxnSp, name: "connection_shape"

  it_should_have_properties :non_visual_connection_shape_properties,
                            :shape_properties, :shape_style, :extension_list
end
