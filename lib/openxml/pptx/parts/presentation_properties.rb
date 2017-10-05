# frozen_string_literals: true

module OpenXml
  module Pptx
    module Parts
      class PresentationProperties < OpenXml::Part
        include OpenXml::RelatablePart
        include OpenXml::ContainsProperties

        relationship_type "http://schemas.openxmlformats.org/officeDocument/2006/relationships/presProps"
        content_type "application/vnd.openxmlformats-officedocument.presentationml.presProps+xml"
        default_path "ppt/presProps.xml"

        # property :print_properties # tag: :prnPr
        # property :show_properties # tag: :showPr
        # property :color_mru # tag: :clrMru, DrawingML type, pptx namespace
        property :extension_list

        def to_xml
          build_standalone_xml do |xml|
            xml[:p].presentationPr(namespaces) do
              property_xml(xml)
            end
          end
        end

      private

        def namespaces
          {
            "xmlns:p": "http://schemas.openxmlformats.org/presentationml/2006/main"
          }
        end

      end
    end
  end
end
