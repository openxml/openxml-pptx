require "openxml/pptx/element"

module OpenXml
  module Pptx
    module Elements
      class SlideLayoutId < OpenXml::Pptx::Element
        tag :sldLayoutId

        attribute :id, expects: :string, namespace: :r

        def initialize(relationship_id)
          super()
          self.id = relationship_id
        end
      end

      class SlideLayoutList < OpenXml::Pptx::Element
        tag :sldLayoutIdLst

        attr_accessor :layout_ids
        private :layout_ids=

        def initialize
          super
          self.layout_ids = []
        end

        def add_layout(relationship)
          layout_ids.push(relationship.id)
        end

        def to_xml(xml)
          xml[namespace].public_send(tag, xml_attributes) do
            layout_ids.each do |layout_id|
              SlideLayoutId.new(layout_id).to_xml(xml)
            end
          end
        end
      end
    end
  end
end
