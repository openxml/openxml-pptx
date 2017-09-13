module OpenXml
  module Pptx
    module Parts
      class Slide < OpenXml::Part
        include OpenXml::RelatablePart
        include OpenXml::HasAttributes
        include OpenXml::ContainsProperties
        attr_reader :images

        relationship_type "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide"
        content_type "application/vnd.openxmlformats-officedocument.presentationml.slide+xml"
        default_path "ppt/slides/slide.xml"

        attribute :show_master_shapes, displays_as: :showMasterSp, expects: :boolean
        attribute :show_master_placeholder_animations, displays_as: :showMasterPhAnim, expects: :boolean
        attribute :show_slide, displays_as: :show, expects: :boolean

        property :common_slide_data, required: true
        property :color_mapping_override

        # = TODO ================
        # property :transition
        # property :timing

        property :extension_list

        LAYOUT_SCHEMA =
          "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout".freeze

        def initialize(*_args)
          super
          @images = []
        end

        # Necessary for HasAttributes
        def name
          "slide"
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

        def set_slide_layout(layout)
          add_relationship layout.relationship_type, layout.path
        end

        def to_xml
          build_standalone_xml do |xml|
            xml[:p].sld(namespaces.merge(xml_attributes)) do
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

      private

        def namespaces
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
