require "spec_helper"

describe OpenXml::Pptx::Properties::SlideSize do
  include PropertyTestMacros

  it_should_use tag: :sldSz, name: "slide_size"

  %i{ length width }.each do |dimension|
    for_attribute(dimension) do
      with_value(1_000_000) do
        it_should_assign_successfully
        it_should_output_expected_xml
      end

      [914_399, 51_206_401, :invalid].each do |bad_value|
        with_value(bad_value) do
          it_should_raise_an_exception
        end
      end
    end
  end


  for_attribute(:type) do
    with_value(:custom) do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    it_should_not_allow_invalid_value
  end
end
