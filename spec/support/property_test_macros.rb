module PropertyTestMacros

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
    attr_reader :instance, :value, :attribute
    base.extend ClassMethods
  end

  module ClassMethods

    def it_should_use(tag: nil, name: nil, namespace: :p, value: nil)
      context "always" do
        before(:each) do
          allow_any_instance_of(described_class).to receive(:build_required_properties)
          if value.nil?
            @instance = described_class.new
          else
            @instance = described_class.new(*value)
          end
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

    def it_should_output(expected_xml, *values, assign: true)
      it "should output the correct XML" do
        allow_any_instance_of(described_class).to receive(:build_required_properties)
        @instance = described_class.new *values
        instance.send "#{attribute}=", value if assign

        expect(xml(instance)).to eq(expected_xml)
      end
    end

    def its_output_should_match(expected_regex, *values, assign: true)
      it "should output the correct XML" do
        allow_any_instance_of(described_class).to receive(:build_required_properties)
        @instance = described_class.new *values
        instance.send "#{attribute}=", value if assign

        expect(xml(instance)).to match(expected_regex)
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

    def for_attribute(attribute, &block)
      attribute_context = context "for the #{attribute} attribute" do
        before(:each) do
          @attribute = attribute
        end
      end

      attribute_context.class_eval &block
    end

    def with_value(value, &block)
      value_context = context "with the value as #{value}" do
        before(:each) do
          @value = value
        end
      end

      value_context.class_eval &block
    end

    def it_should_assign_successfully(*values)
      it "should assign successfully" do
        expect do
          allow_any_instance_of(described_class).to receive(:build_required_properties)
          obj = described_class.new *values
          obj.send "#{attribute}=", value
        end.to_not raise_error
      end
    end

    def it_should_raise_an_exception
      it "should raise an exception" do
        expect do
          allow_any_instance_of(described_class).to receive(:build_required_properties)
          obj = described_class.new
          obj.send "#{attribute}=", value
        end.to raise_error(ArgumentError)
      end
    end

    def with_no_attributes_set(&block)
      attribute_context = context "with no attributes set" do
        before(:each) do
          allow_any_instance_of(described_class).to receive(:build_required_properties)
          @instance = described_class.new
        end
      end

      attribute_context.class_eval &block
    end

    def with_these_attributes_set(attributes, &block)
      attribute_context = context "with valid attributes set" do
        before(:each) do
          allow_any_instance_of(described_class).to receive(:build_required_properties)
          @instance = described_class.new
          attributes.each do |attr, val|
            instance.send "#{attr}=", val
          end
        end
      end

      attribute_context.class_eval &block
    end

    def it_should_output_expected_xml(*values, expected_xml: nil)
      it "should output the correct XML" do
        allow_any_instance_of(described_class).to receive(:build_required_properties)
        @instance = described_class.new *values
        instance.send "#{attribute}=", value
        property_name, property_namespace = instance.attributes[attribute]
        expected_xml ||= "<p:#{instance.tag} #{property_namespace}#{property_namespace.nil? ? "" : ":"}#{property_name}=\"#{value}\"/>"

        expect(xml(instance)).to eq(expected_xml)
      end
    end

    def it_should_assign_and_output_xml(values)
      values = [values] unless values.respond_to? :each
      values.each do |value|
        with_value(value) do
          it_should_assign_successfully
          it_should_output_expected_xml
        end
      end
    end

    def it_should_behave_like_a_boolean_attribute
      with_value(true) do
        it_should_assign_successfully
        it_should_output_expected_xml
      end

      with_value(false) do
        it_should_assign_successfully
        it_should_output_expected_xml
      end
    end

    def it_should_not_allow_invalid_value
      with_value(:invalid) do
        it_should_raise_an_exception
      end
    end

    def it_should_not_allow_integers
      with_value(1) do
        it_should_raise_an_exception
      end
    end
    def it_should_not_allow_floats
      with_value(12.1) do
        it_should_raise_an_exception
      end
    end

    def it_should_not_allow_negative_numbers
      with_value(-1) do
        it_should_raise_an_exception
      end
    end

    def it_should_not_allow_nil
      with_value(nil) do
        it_should_raise_an_exception
      end
    end
  end
end
