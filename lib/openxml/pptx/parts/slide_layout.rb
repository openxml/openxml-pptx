# frozen_string_literals: true

module OpenXml
  module Pptx
    module Parts
      class SlideLayout < OpenXml::Part
        include OpenXml::RelatablePart
        include OpenXml::HasAttributes
        include OpenXml::ContainsProperties
        attr_reader :images

        relationship_type "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout"
        content_type "application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml"
        default_path "ppt/slideLayouts/slideLayout.xml"

        attribute :show_master_shapes, displays_as: :showMasterSp, expects: :boolean
        attribute :show_master_placeholder_animations, displays_as: :showMasterPhAnim, expects: :boolean
        attribute :matching_name, displays_as: :matchingName, expects: :string
        attribute :type, one_of: OpenXml::Pptx::ST_SlideLayoutType
        attribute :preserve, expects: :boolean
        attribute :drawn_by_user, displays_as: :userDrawn, expects: :boolean

        property :common_slide_data, required: true
        property :color_mapping_override

        # = TODO ================
        # property :transition
        # property :timing
        # property :header_footer

        property :extension_list

        def initialize(*_args)
          super
          @images = []
        end

        # Necessary for HasAttributes
        def name
          "slide_layout"
        end

        def set_slide_master(master)
          add_relationship master.relationship_type, master.path
        end

        def add_image(image_part)
          images.push(image_part)
          index = (parent && parent.next_image_index) || images.count
          add_child_part(image_part, with_index: index)
        end

        def build_image_part(path)
          path = Pathname.new(path)
          OpenXml::Pptx::Parts::Image.new(path.read, extension: path.extname).tap do |image|
            add_image(image)
          end
        end

        def to_xml
          build_standalone_xml do |xml|
            xml[:p].sldLayout(namespaces.merge(xml_attributes)) do
              property_xml(xml)
            end
          end
        end

        # Convenience accessors
        def shapes
          common_slide_data.shape_tree.shapes
        end

        def background_properties
          common_slide_data.background.background_properties
        end

        private def namespaces
          {
            "xmlns:a": "http://schemas.openxmlformats.org/drawingml/2006/main",
            "xmlns:r": "http://schemas.openxmlformats.org/officeDocument/2006/relationships",
            "xmlns:p": "http://schemas.openxmlformats.org/presentationml/2006/main"
          }
        end

      end
    end
  end
end
