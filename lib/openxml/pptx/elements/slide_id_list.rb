require "openxml/pptx/element"

module OpenXml
  module Pptx
    module Elements
      class SlideId < OpenXml::Pptx::Element
        tag :sldId

        attribute :rid, displays_as: :id, expects: :string, namespace: :r
        attribute :id, expects: :positive_integer

        def initialize(relationship_id)
          super()
          self.rid = relationship_id.to_s
          self.id = object_id % OpenXml::Pptx::MAX_ID_SIZE
        end
      end

      class SlideIdList < OpenXml::Pptx::Element
        tag :sldIdLst

        attr_accessor :slide_ids
        private :slide_ids=

        def initialize
          super
          self.slide_ids = []
        end

        def add_slide(relationship)
          slide_ids.push(SlideId.new(relationship.id))
        end

        def to_xml(xml)
          return xml if slide_ids.empty?
          xml[namespace].public_send(tag, xml_attributes) do
            slide_ids.each do |slide_id|
              slide_id.to_xml(xml)
            end
          end
        end
      end
    end
  end
end
