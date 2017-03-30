require "openxml/extract/element"
require "securerandom"

module OpenXml
  module Pptx
    module Elements
      class SlideId < OpenXml::Element
        tag :sldId

        attribute :rid, displays_as: :id, expects: :string, namespace: :r
        attribute :id, expects: :string

        def initialize(relationship_id)
          super()
          self.rid = relationship_id
          self.id = SecureRandom.hex
        end
      end

      class SlideIdList < OpenXml::Element
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
          xml[namespace].public_send(tag, xml_attributes) {
            slide_ids.each do |slide_id|
              slide_id.to_xml(xml)
            end
          }
        end
      end
    end
  end
end
