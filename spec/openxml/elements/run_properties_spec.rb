require "spec_helper"
require "support/matchers/generate_tag"
require "openxml/elements/run_properties"

RSpec.describe OpenXml::Elements::RunProperties do
  context "with no set properties" do
    it do
      is_expected.to generate_tag("")
    end
  end

  context "with properties" do
    subject { described_class.new(:italic, size: 100) }
    it do
      is_expected.to generate_tag("<a:rPr i='true' sz='100'/>")
    end
  end

  it do
    is_expected.to have_boolean_attribute(:italic)
  end

  it do
    is_expected.to have_boolean_attribute(:bold)
  end

  it do
    is_expected.to support_value_property(:size).in_range(100..400_000)
  end

  it do
    is_expected.to_not support_value_property(:size).in([99, 400_001, -100])
  end

  it do
    is_expected.to support_value_property(:strike).in(%w[sngStrike dblStrike noStrike])
  end

  it do
    is_expected.to_not support_value_property(:strike).in(%w[not_supported])
  end

  it do
    is_expected.to support_value_property(:underline).in(%w[
                                                         dash
                                                         dashHeavy
                                                         dashLong
                                                         dashLongHeavy
                                                         dbl
                                                         dotDash
                                                         dotDashHeavy
                                                         dotDotDash
                                                         dotDotDashHeavy
                                                         dotted
                                                         dottedHeavy
                                                         heavy
                                                         none
                                                         sng
                                                         wavy
                                                         wavyDbl
                                                         wavyHeavy
                                                         words
    ])
  end

  it do
    is_expected.to_not support_value_property(:underline).in(%w[not_supported])
  end

  matcher :have_boolean_attribute do |attribute|
    match do
      instance = described_class.new(attribute)
      instance.public_send(attribute) == true
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
end
