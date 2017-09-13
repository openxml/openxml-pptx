require "spec_helper"

describe OpenXml::Pptx::Properties::NotesMasterId do
  include PropertyTestMacros

  it_should_use tag: :notesMasterId, name: "notes_master_id"

  it_should_have_property :extension_list

  for_attribute(:rid) do
    with_value("rId256") do
      it_should_assign_successfully
      it_should_output "<p:notesMasterId r:id=\"rId256\"/>"
    end

    it_should_not_allow_invalid_value
  end
end
