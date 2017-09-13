require "spec_helper"

describe OpenXml::Pptx::Properties::PhotoAlbum do
  include PropertyTestMacros

  it_should_use tag: :photoAlbum, name: "photo_album"

  %i{ black_and_white show_captions }.each do |boolean_attribute|
    for_attribute(boolean_attribute) do
      it_should_behave_like_a_boolean_attribute
    end
  end

  for_attribute(:frame) do
    with_value(:frameStyle1) do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    %i{ frameStyle0 invalid }.each do |bad_value|
      with_value(bad_value) do
        it_should_raise_an_exception
      end
    end
  end

  for_attribute(:layout) do
    with_value(:fitToSlide) do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    it_should_not_allow_invalid_value
  end
end
