require "spec_helper"

describe OpenXml::Pptx::Properties::CustomShowList do
  include PropertyTestMacros

  it_should_use tag: :custShowLst, name: "custom_show_list"

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
      instance << OpenXml::Pptx::Properties::CustomShow.new.tap do |show|
        show.show_name = "A Show"
        show.id = 256
      end
    end

    it "should output the correct XML" do
      expect(xml(instance)).to eq("<p:custShowLst>\n    <p:custShow id=\"256\" name=\"A Show\"/>\n  </p:custShowLst>")
    end
  end
end
