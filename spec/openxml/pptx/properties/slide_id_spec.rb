require "spec_helper"

describe OpenXml::Pptx::Properties::SlideId do
  include PropertyTestMacros

  it_should_use tag: :sldId, name: "slide_id"

  it_should_have_property :extension_list

  for_attribute(:id) do
    with_value(300) do
      it_should_assign_successfully
      it_should_output_expected_xml
    end

    [100, -100, 2_147_483_649, :invalid].each do |bad_value|
      with_value(bad_value) do
        it_should_raise_an_exception
      end
    end
  end

  for_attribute(:rid) do
    with_value("rId256") do
      it_should_assign_successfully
      its_output_should_match %r{^<p:sldId id="\d+" r:id="rId256"/>}
    end

    it_should_not_allow_invalid_value
  end
end
