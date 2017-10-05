require "spec_helper"

describe OpenXml::Pptx::Properties::ColorMapping do
  include PropertyTestMacros

  it_should_use tag: :clrMap, name: "color_mapping"

  it_should_have_property :extension_list

  GOOD_VALUES = %i{
    dk1 lt1 dk2 lt2 accent1 accent2 accent3 accent4 accent5 accent6 hlink folHlink
  }.freeze

  %i{ bg1 bg2 tx1 tx2 accent1 accent2 accent3 accent4 accent5 accent6
      hlink folHlink }.each do |color|
    for_attribute(color) do
      GOOD_VALUES.each do |good_value|
        with_value(good_value) do
          it_should_assign_successfully
          it_should_output_expected_xml
        end
      end

      it_should_not_allow_invalid_value
    end
  end
end
