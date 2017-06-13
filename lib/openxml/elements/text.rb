module OpenXml
  module Elements
    class Text < OpenXml::Pptx::Element
      namespace :a
      tag :t

      attr_accessor :text
      private :text=

      def initialize(text)
        self.text = text
      end

      def to_xml(xml)
        xml[namespace].public_send(tag, text, xml_attributes)
      end
    end
  end
end
