require "spec_helper"

describe OpenXml::Pptx::Properties::GraphicFrame do
  include PropertyTestMacros

  it_should_use tag: :graphicFrame, name: "graphic_frame"

  it_should_have_properties :non_visual_graphic_frame_properties, :transform,
                            :graphic, :extension_list

  for_attribute(:bw_mode) do
    with_value(:white) do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    it_should_not_allow_invalid_value
  end
end
