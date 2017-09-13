require "spec_helper"

describe OpenXml::Pptx::Properties::EmbeddedFont do
  include PropertyTestMacros

  it_should_use tag: :embeddedFont, name: "embedded_font"

  it_should_have_value_property :font
  it_should_have_properties :regular, :bold, :italic, :bold_italic
end
