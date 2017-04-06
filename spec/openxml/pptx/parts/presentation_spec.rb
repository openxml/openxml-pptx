require "spec_helper"

RSpec.describe OpenXml::Pptx::Parts::Presentation do
  let(:subject) { OpenXml::Pptx::Package.new.presentation }

  describe "with a relationship" do
    let(:relationship) { :relationship }

    before do
      subject.add_relationship relationship
    end

    specify do
      expect(subject.relationships).to include(relationship)
    end
  end
end
