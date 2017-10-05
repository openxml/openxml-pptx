module OpenXml
  module Pptx
    module Properties
      class TransparentContainerProperty < OpenXml::Properties::ContainerProperty

        def to_xml(xml)
          return unless render?
          each { |child| child.to_xml(xml) }
        end

      end
    end
  end
end
