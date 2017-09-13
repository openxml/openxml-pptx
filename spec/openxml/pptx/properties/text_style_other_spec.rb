require "spec_helper"

describe OpenXml::Pptx::Properties::TextStyleOther do
  include PropertyTestMacros

  it_should_use tag: :otherStyle, name: "text_style_other"

  it_should_have_properties :default_paragraph_properties, :level1_paragraph_properties,
                            :level2_paragraph_properties, :level3_paragraph_properties,
                            :level4_paragraph_properties, :level5_paragraph_properties,
                            :level6_paragraph_properties, :level7_paragraph_properties,
                            :level8_paragraph_properties, :level9_paragraph_properties,
                            :extension_list
end
