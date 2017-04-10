require "rspec/matchers"
require "equivalent-xml"

RSpec::Matchers.define :generate_tag do |tag|
  match do |actual|
    @actual = xml(actual)
    expect(@actual).to be_equivalent_to(tag)
  end

  def isolate_tag(xml)
    /<\?xml\sversion="1.0"\?>\n<root (?:xmlns:\w+=".+?".?)+>\n\s+([^\s].+)\n<\/root>/m =~ xml
    $1 || ""
  end

  def xml(actual)
    isolate_tag(Nokogiri::XML::Builder.new { |xml|
      xml.root("xmlns:p": "pnamespace", "xmlns:a": "anamespace") do
        xml = subject.to_xml(xml)
      end
    }.to_xml)
  end

  diffable
end
