module ValuePropertyTestMacros

  def relax_requirements_for(obj)
    allow(obj).to receive(:ensure_required_attributes_set)
    allow(obj).to receive(:ensure_required_choices)
  end

  def xml(obj)
    relax_requirements_for(obj)
    doc = Nokogiri::XML::Builder.new do |xml|
      xml.root("xmlns:a" => "http://anamespace.org",
               "xmlns:r" => "http://rnamespace.org",
               "xmlns:p" => "http://pnamespace.org") {
        obj.to_xml(xml)
      }
    end.to_xml
    doc_pattern =~ doc ? $1 : ""
  end

  def doc_pattern
    /<\?xml\sversion="1.0"\?>\n<root xmlns:a="http:\/\/anamespace.org" xmlns:r="http:\/\/rnamespace.org" xmlns:p="http:\/\/pnamespace.org">\n\s+([^\s].+)\n<\/root>/m
  end

  def self.included(base)
    attr_reader :instance, :value
    base.extend ClassMethods
  end

  module ClassMethods

    def it_should_use(tag: nil, name: nil, namespace: :p, value: nil)
      context "always" do
        before(:each) do
          allow_any_instance_of(described_class).to receive(:build_required_properties)
          @instance = described_class.new(value)
        end

        it "should use the correct tag" do
          expect(instance.tag).to eq(tag)
        end

        it "should use the correct name" do
          expect(instance.name).to eq(name)
        end

        it "should use the correct namespace" do
          expect(instance.namespace).to eq(namespace)
        end
      end
    end

    def it_should_output(expected_xml)
      it "should output the correct XML" do
        allow_any_instance_of(described_class).to receive(:build_required_properties)
        @instance = described_class.new(value)
        expect(xml(instance)).to eq(expected_xml)
      end
    end

    def it_should_have_properties(*properties, value: nil)
      properties.each do |property|
        it "should have the property #{property}" do
          allow_any_instance_of(described_class).to receive(:build_required_properties)
          expect(described_class.new(value).respond_to?(property)).to be true
        end
      end
    end
    alias it_should_have_property it_should_have_properties

    def it_should_have_value_properties(*properties, value: nil)
      properties.each do |property|
        it "should have the value property #{property}" do
          allow_any_instance_of(described_class).to receive(:build_required_properties)
          @instance = described_class.new(value)
          expect(instance.respond_to?(property)).to be true
          expect(instance.respond_to?(:"#{property}=")).to be true
        end
      end
    end
    alias it_should_have_value_property it_should_have_value_properties

    def with_value(value, &block)
      value_context = context "when the value is #{value.inspect}" do
        before(:each) do
          @value = value
        end
      end

      value_context.class_eval &block
    end

    def it_should_work
      it "should not raise an exception" do
        allow_any_instance_of(described_class).to receive(:build_required_properties)
        expect { described_class.new(value) }.to_not raise_error
      end
    end

    def it_should_not_work
      it "should raise an exception" do
        allow_any_instance_of(described_class).to receive(:build_required_properties)
        expect { described_class.new(value) }.to raise_error(ArgumentError)
      end
    end

  end
end
