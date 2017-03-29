require "openxml/extract/element"

module OpenXml
  module Pptx
    module Elements
      class ColorMap < OpenXml::Element
        tag :cSld

        attribute :bg1
        attribute :tx1
        attribute :bg2
        attribute :tx2
        attribute :accent1
        attribute :accent2
        attribute :accent3
        attribute :accent4
        attribute :accent5
        attribute :accent6
        attribute :hlink
        attribute :folHlink

        def to_xml(xml)
          xml[namespace].public_send(tag, xml_attributes)
        end
      end
    end
  end
end
