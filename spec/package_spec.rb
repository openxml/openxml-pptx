require "spec_helper"
require "pry"

RSpec::Matchers.define :have_part_at do |part_path|
  match do |package|
    @actual = distill(package.get_part(part_path).content)
    values_match? @expected, @actual
  end

  chain :with_content do |expected_content|
    @expected = distill(expected_content)
  end

  define_method :ignore_ids do |content|
    content.gsub(/ Id="[^"]+"/, "")
  end

  define_method :squish do |content|
    content.gsub(/[\n\r]/, "")
  end

  define_method :distill do |content|
    squish(ignore_ids(content))
  end

  failure_message do
    """
    Expected #{part_path} to be
    #{@expected.inspect.gsub("<", "\n<")}
    but got
    #{@actual.inspect.gsub("<", "\n<")}
    """
  end
end

describe OpenXml::Pptx::Package do
  attr_reader :package

  context "when starting a new package" do
    subject { described_class.new }

    specify do
      expect(subject.content_types).to be_instance_of(OpenXml::Parts::ContentTypes)
    end

    specify do
      expect(entries_of(subject)).to contain_exactly(*entries_of(fixture("minimal")))
    end

    specify do
      aggregate_failures do
        fixture("minimal").parts.each do |part_path, expected_part|
          is_expected.to have_part_at(part_path).with_content(expected_part.content)
        end
      end
    end
  end

  def entries_of(package)
    package.parts.keys
  end

  def fixture(fixture_name)
    pathname = Pathname("spec/fixtures/#{fixture_name}.pptx")
    OpenXml::Pptx::Package.open(pathname.realpath)
  end
end
