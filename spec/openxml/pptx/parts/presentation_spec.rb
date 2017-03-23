require "spec_helper"

RSpec.describe OpenXml::Pptx::Parts::Presentation do
  describe "with no relationships" do
    specify do
      expect(subject.relationships).to be_empty
    end
  end

  describe "with a relationship" do
    let(:path) { "path" }
    let(:schema) { "schema" }

    before do
      subject.add_relationship schema, path
    end

    specify do
      expect(subject.relationships).to_not be_empty
    end
  end
end
