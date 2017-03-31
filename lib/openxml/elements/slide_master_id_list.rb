require "openxml/extract/element"

module OpenXml
  module Pptx
    module Elements
      class SlideMasterId < OpenXml::Element
        tag :sldMasterId

        attribute :id, expects: :string, namespace: :r

        def initialize(relationship_id)
          super()
          self.id = relationship_id
        end
      end

      class SlideMasterIdList < OpenXml::Element
        tag :sldMasterIdLst

        attr_accessor :master_ids
        private :master_ids=

        def initialize
          super
          self.master_ids = []
        end

        def add_master(relationship)
          master_ids.push(SlideMasterId.new(relationship.id))
        end

        def to_xml(xml)
          xml[namespace].public_send(tag, xml_attributes) {
            master_ids.each do |master_id|
              master_id.to_xml(xml)
            end
          }
        end
      end
    end
  end
end
