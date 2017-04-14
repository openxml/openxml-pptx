require "spec_helper"
require "support/matchers/generate_tag"
require "openxml/pptx/elements/background_properties"

RSpec.describe OpenXml::Pptx::Elements::BackgroundProperties do
  context "with no set properties" do
    it do
      is_expected.to generate_tag("")
    end
  end

  it do
    is_expected.to only_allow_initial_setting_of(:color)
  end

  context "with color" do
    let(:color) { "929292" }
    subject { described_class.new(color: color) }

    it do
      is_expected.to generate_tag(<<~XML
                                  <p:bgPr>
                                    <a:solidFill>
                                      <a:srgbClr val='#{color}'/>
                                    </a:solidFill>
                                  </p:bgPr>
                                 XML
                                 )
    end
  end

  matcher :support_value_property do |attribute|
    match do
      @failures = []
      Array(values).each do |val|
        begin
          instance = described_class.new(attribute => val)
          @failures.push val  unless instance.public_send(attribute) == val
        rescue ArgumentError
          @failures.push val
        end
      end

      @failures.empty?
    end

    match_when_negated do
      @failures = []

      Array(values).each do |val|
        begin
          instance = described_class.new(attribute => val)
          @failures.push val
        rescue ArgumentError
        end
      end

      @failures.empty?
    end

    failure_message do
      "expected all values to be accepted, but #{@failures} were rejected"
    end

    failure_message_when_negated do
      "expected all values to be rejected, but #{@failures} were accepted"
    end

    chain :in, :values

    chain :in_range do |range|
      @values = [range.first, range.last]
    end
  end

  matcher :only_allow_initial_setting_of do |property|
    match do
      expect{subject.public_send("#{property}=", "a")}.to raise_error(NoMethodError, /private method/)
    end
  end

end
