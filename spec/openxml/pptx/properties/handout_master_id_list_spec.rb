require "spec_helper"

describe OpenXml::Pptx::Properties::HandoutMasterIdList do
  include PropertyTestMacros

  it_should_use tag: :handoutMasterIdLst, name: "handout_master_id_list"

  context "when adding children" do
    before(:each) do
      @instance = described_class.new
    end

    it "should raise an exception if the child isn't one of the accepted properties" do
      expect { instance << [] }.to raise_error(ArgumentError)
    end
  end

  context "when there are no children" do
    before(:each) do
      @instance = described_class.new
    end

    it "should not output any XML" do
      expect(xml(instance)).to eq("")
    end
  end

  context "when there is a child" do
    before(:each) do
      @instance = described_class.new
      instance << OpenXml::Pptx::Properties::HandoutMasterId.new.tap do |master_id|
        master_id.rid = "rId256"
      end
    end

    it "should output the correct XML" do
      expect(xml(instance)).to eq("<p:handoutMasterIdLst>\n    <p:handoutMasterId r:id=\"rId256\"/>\n  </p:handoutMasterIdLst>")
    end
  end
end
