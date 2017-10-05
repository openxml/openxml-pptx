require "spec_helper"

describe OpenXml::Pptx::Properties::BackgroundReference do
  include PropertyTestMacros

  it_should_use tag: :bgRef, name: "background_reference"

  it_should_have_properties :component_rgb, :hsl
  it_should_have_value_properties :rgb, :system_color, :scheme_color, :preset_color

  for_attribute(:index) do
    with_value(100) do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    [-100, :invalid].each do |bad_value|
      with_value(bad_value) do
        it_should_raise_an_exception
      end
    end
  end
end
