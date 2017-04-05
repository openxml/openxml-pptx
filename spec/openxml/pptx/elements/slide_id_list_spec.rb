require "spec_helper"
require "openxml/elements/slide_id_list"
require "rspec/matchers"
require "equivalent-xml"
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

  specify do
    xml = Nokogiri::XML::Builder.new { |xml|
      xml.root("xmlns:p": "pnamespace") do
        xml = subject.to_xml(xml)
      end
    }.to_xml
    expected_output = """
    <p:sldId id=\"#{subject.id}\" r:id=\"#{subject.rid}\"/>
    """
    expect(isolate_tag(xml)).to be_equivalent_to(expected_output)
  end

  def isolate_tag(xml)
    /<\?xml\sversion="1.0"\?>\n<root (?:xmlns:\w+=".+?".?)+>\n\s+([^\s].+)\n<\/root>/m =~ xml
    $1
  end
end
