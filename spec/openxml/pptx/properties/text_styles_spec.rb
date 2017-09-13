require "spec_helper"

describe OpenXml::Pptx::Properties::TextStyles do
  include PropertyTestMacros

  it_should_use tag: :txStyles, name: "text_styles"

  it_should_have_properties :title, :body, :other, :extension_list
end
