require "spec_helper"

describe OpenXml::Pptx::Properties::ControlList do
  include PropertyTestMacros

  it_should_use tag: :controls, name: "control_list"

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
      instance << OpenXml::Pptx::Properties::Control.new.tap do |control|
        control.control_name = "A Control"
      end
    end

    it "should output the correct XML" do
      expect(xml(instance)).to eq("<p:controls>\n    <p:control name=\"A Control\"/>\n  </p:controls>")
    end
  end
end
