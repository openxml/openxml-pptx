require "spec_helper"

describe OpenXml::Pptx::Properties::FontReferenceItalic do
  include PropertyTestMacros

  it_should_use tag: :italic, name: "font_reference_italic"

  for_attribute(:rid) do
    with_value("rId256") do
      it_should_assign_successfully
      it_should_output "<p:italic r:id=\"rId256\"/>"
    end

    it_should_not_allow_invalid_value
  end
end
