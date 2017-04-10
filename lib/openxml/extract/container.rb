module OpenXml
  class Container < Element
    attr_reader :children

    def initialize
      @children = []
    end

    def <<(child)
      children << child
    end

    def push(child)
      children.push(child)
    end

    def to_xml(xml)
      xml[namespace].public_send(tag, xml_attributes) {
        children.each { |child| child.to_xml(xml) }
      }
    end
  end
end
