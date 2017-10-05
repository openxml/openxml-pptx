require "spec_helper"

describe OpenXml::Pptx::Properties::CustomerDataList do
  include PropertyTestMacros

  it_should_use tag: :custDataLst, name: "customer_data_list"

  it_should_have_properties :data, :tags

  context "when adding children to data" do
    before(:each) do
      @instance = described_class.new
    end

    it "should raise an exception if the child isn't one of the accepted properties" do
      expect { instance.data << [] }.to raise_error(ArgumentError)
    end
  end

  context "when there is a child" do
    before(:each) do
      @instance = described_class.new
      instance.data << OpenXml::Pptx::Properties::CustomerData.new.tap do |datum|
        datum.rid = "rId256"
      end
    end

    it "should output the correct XML" do
      expect(xml(instance)).to eq("<p:custDataLst>\n    <p:custData r:id=\"rId256\"/>\n  </p:custDataLst>")
    end
  end
end
