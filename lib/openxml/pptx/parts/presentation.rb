# frozen_string_literals: true

module OpenXml
  module Pptx
    module Parts
      class Presentation < OpenXml::Part
        include OpenXml::RelatablePart
        include OpenXml::HasAttributes
        include OpenXml::ContainsProperties
        attr_reader :slides, :slide_masters, :themes, :presentation_properties

        relationship_type "http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument"
        content_type "application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"
        default_path "ppt/presentation.xml"

        attribute :auto_compress_pictures, displays_as: :autoCompressPict, expects: :boolean
        attribute :bookmark_id_seed, displays_as: :bookmarkIdSeed, expects: :integer, in_range: (1..2_147_483_648)
        attribute :compatibility_mode, displays_as: :compatMode, expects: :boolean
        attribute :conformance, one_of: %i{ strict transitional }
        attribute :embed_fonts, displays_as: :embedTrueTypeFonts, expects: :boolean
        attribute :first_slide_number, displays_as: :firstSlideNum, expects: :integer
        attribute :remove_personal_information_on_save, displays_as: :removePersonalInfoOnSave, expects: :boolean
        attribute :right_to_left, displays_as: :rtl, expects: :boolean
        attribute :save_subset_fonts, displays_as: :saveSubsetFonts, expects: :boolean
        attribute :server_zoom, displays_as: :serverZoom, expects: :percentage
        attribute :show_special_placeholders_on_title_slide, displays_as: :showSpecialPlsOnTitleSld, expects: :boolean
        attribute :strict_first_and_last_characters, displays_as: :strictFirstAndLastChars, expects: :boolean

        property :slide_master_id_list
        property :notes_master_id_list
        property :handout_master_id_list
        property :slide_id_list
        property :slide_size
        property :notes_size, required: true
        property :smart_tags
        property :embedded_font_list
        property :custom_show_list
        property :photo_album
        # property :customer_data_list # tag :custDataLst
        # property :kinsoku
        property :default_text_style
        # property :modification_verifier # tag :modifyVerifier

        property :extension_list

        # For proper interaction with HasAttributes
        def self.tag
          :presentation
        end

        def self.namespace
          :p
        end

        def name
          "presentation"
        end

        def initialize(**_kwargs)
          super(**_kwargs)
          @slides = []
          @slide_masters = []
          @themes = []
          @presentation_properties = OpenXml::Pptx::Parts::PresentationProperties.new
          add_child_part(presentation_properties)

          # Set defaults
          slide_size.length = 12_192_000
          slide_size.width = 6_858_000
          notes_size.length = 6_858_000
          notes_size.width = 9_144_000
        end

        def add_slide(slide)
          slides.push(slide)
          add_child_part(slide, with_index: slides.count)
          slide_id_list << OpenXml::Pptx::Properties::SlideId.new.tap do |slide_id|
            slide_id.rid = relationships_by_path[slide.path].id
          end
        end

        def build_slide(named: nil, slide_layout: nil)
          OpenXml::Pptx::Parts::Slide.new.tap do |slide|
            slide.common_slide_data.slide_name = named unless named.nil?
            slide.set_slide_layout(slide_layout) unless slide_layout.nil?
            add_slide(slide)
          end
        end

        def add_slide_master(slide_master)
          slide_masters.push(slide_master)
          add_child_part(slide_master, with_index: slide_masters.count)
          slide_master_id_list << OpenXml::Pptx::Properties::SlideMasterId.new.tap do |master_id|
            master_id.rid = relationships_by_path[slide_master.path].id
          end
        end

        def build_slide_master(named: nil, theme: nil)
          OpenXml::Pptx::Parts::SlideMaster.new.tap do |slide_master|
            slide_master.common_slide_data.slide_name = named unless named.nil?
            slide_master.set_theme(theme) unless theme.nil?
            add_slide_master(slide_master)
          end
        end

        def add_theme(theme)
          themes.push(theme)
          add_child_part(theme, with_index: themes.count)
        end

        def build_theme
          OpenXml::Pptx::Parts::Theme.new.tap do |theme|
            add_theme(theme)
          end
        end

        def next_image_index
          @image_index = (@image_index || 0) + 1
        end

        def to_xml
          build_standalone_xml do |xml|
            xml[:p].presentation(namespaces.merge(xml_attributes)) do
              property_xml(xml)
            end
          end
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
