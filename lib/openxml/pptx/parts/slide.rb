module OpenXml
  module Pptx
    module Parts
      class Slide < OpenXml::Part
        attr_accessor :relationships, :id
        private :relationships=, :id=

        def initialize
          self.relationships = OpenXml::Parts::Rels.new
        end

        def add_to(ancestors)
          parent, *rest = ancestors

          parent.add_slide_relationship "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide", "slides/slide1.xml"
        end
      end
    end
  end
end
