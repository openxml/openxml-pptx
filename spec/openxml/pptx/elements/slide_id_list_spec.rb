require "spec_helper"
require "support/matchers/generate_tag"
require "openxml/pptx/elements/slide_id_list"
require "securerandom"

RSpec.describe OpenXml::Pptx::Elements::SlideId do
  let(:relationship_id) { SecureRandom.hex }
  subject { described_class.new(relationship_id) }

  specify do
    expect(subject.rid).to eql(relationship_id)
  end

  specify do
    expect(subject.id).to_not be_nil
    expect(subject.id).to_not eql(relationship_id)
  end

  it do
    expected_output = """
    <p:sldId id=\"#{subject.id}\" r:id=\"#{subject.rid}\"/>
    """
    is_expected.to generate_tag(expected_output)
  end
end
