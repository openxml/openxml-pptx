require "spec_helper"

describe OpenXml::Pptx::Properties::HandoutMasterId do
  include PropertyTestMacros

  it_should_use tag: :handoutMasterId, name: "handout_master_id"

  it_should_have_property :extension_list

  for_attribute(:rid) do
    with_value("rId256") do
      it_should_assign_successfully
      it_should_output "<p:handoutMasterId r:id=\"rId256\"/>"
    end

    it_should_not_allow_invalid_value
  end
end
