require "spec_helper"

describe OpenXml::Pptx::Package do
  attr_reader :package

  context "when starting a new package" do
    before(:each) do
      @package = described_class.new
    end

    it "should create the content types part" do
      expect(package.content_types).to be_instance_of(OpenXml::Parts::ContentTypes)
    end
  end

end
