# frozen_string_literals: true

module OpenXml
  module Pptx
    module Parts
      class SlideMaster < OpenXml::Part
        include OpenXml::RelatablePart
        include OpenXml::HasAttributes
        include OpenXml::ContainsProperties
        attr_reader :theme, :layouts, :images

        relationship_type "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster"
        content_type "application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml"
        default_path "ppt/slideMasters/slideMaster.xml"

        attribute :should_preserve, displays_as: :preserve, expects: :boolean

        property :common_slide_data, required: true
        property :color_mapping, required: true
        property :slide_layout_id_list

        # = TODO ================
        # property :transition
        # property :timing
        # property :header_footer

        property :text_styles

        property :extension_list

        def initialize(*_args)
          super
          @layouts = []
          @images = []
        end

        # Necessary for HasAttributes
        def name
          "slide_master"
        end

        def set_theme(theme)
          @theme = theme
          add_relationship theme.relationship_type, theme.path
        end

        def add_slide_layout(layout)
          layouts.push(layout)
          add_child_part(layout, with_index: layouts.count)
          slide_layout_id_list << OpenXml::Pptx::Properties::SlideLayoutId.new.tap do |layout_id|
            layout_id.rid = relationships_by_path[layout.path].id
          end
        end

        def build_slide_layout(named: nil)
          OpenXml::Pptx::Parts::SlideLayout.new.tap do |layout|
            layout.set_slide_master(self)
            layout.common_slide_data.slide_name = named unless named.nil?
            add_slide_layout(layout)
          end
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

        def next_image_index
          @image_index = (parent && parent.next_image_index) || @image_index + 1
        end

        def to_xml
          build_standalone_xml do |xml|
            xml[:p].sldMaster(namespaces.merge(xml_attributes)) do
              property_xml(xml)
            end
          end
        end

        def build_required_properties
          super
          DEFAULT_COLOR_MAPPING.each do |key, value|
            color_mapping.public_send(:"#{key}=", value)
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

        DEFAULT_COLOR_MAPPING = {
          bg1: :lt1,
          tx1: :dk1,
          bg2: :lt2,
          tx2: :dk2,
          accent1: :accent1,
          accent2: :accent2,
          accent3: :accent3,
          accent4: :accent4,
          accent5: :accent5,
          accent6: :accent6,
          hlink: :hlink,
          folHlink: :folHlink
        }.freeze

      end
    end
  end
end
