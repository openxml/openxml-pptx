require "spec_helper"

describe OpenXml::Pptx::Properties::NonVisualProperties do
  include PropertyTestMacros

  it_should_use tag: :nvPr, name: "non_visual_properties"

  it_should_have_properties :placeholder, :audio_cd, :wav_audio_file, :audio_file,
                            :video_file, :quick_time_file, :customer_data_list,
                            :extension_list

  %i{ is_photo user_drawn }.each do |boolean_attrs|
    for_attribute(boolean_attrs) do
      it_should_behave_like_a_boolean_attribute
    end
  end
end
