require "openxml/pptx/elements/pictrue"
require "openxml/pptx/elements/non_visual_picture_properties"
require "openxml/pptx/elements/non_visual_picture_drawing_properties"
require "openxml/pptx/elements/blip_fill"
require "openxml/elements/body_properties"

module OpenXml
  module Shapes
    class Image
      TYPES = {
        "jpg" => "image/jpeg",
      }
      attr_accessor :bounds, :image
      private :bounds=, :image=

      def initialize(image, bounds)
        self.bounds = bounds
        self.image = image
      end

      def relationship
        @relationship ||= OpenXml::Elements::Relationship.new(
          "http://schemas.openxmlformats.org/officeDocument/2006/relationships/image",
          "/ppt/media/#{image.basename}"
        )
      end

      def add_to(ancestors)
        parent, *rest = ancestors
        parent.add_relationship relationship
        parent.add_default rest, extension, type
        parent.add_part rest, "media/#{image.basename}", OpenXml::Parts::UnparsedPart.new(image.read)
      end

      private def extension
        image.extname[1..-1]
      end

      private def type
        OpenXml::Shapes::Image::TYPES.fetch(extension) { "image/#{extension}" }
      end

      def to_xml(xml)
        OpenXml::Pptx::Elements::Picture.new.tap { |picture|
          picture << nonvisual_picture_property
          picture << blip_fill
          picture << shape_property
        }.to_xml(xml)
      end

      def nonvisual_picture_property
        @nonvisual_picture_property ||=
          OpenXml::Pptx::Elements::NonVisualPictureProperties.new.tap { |nv_pic_property|
          nv_pic_property <<
          OpenXml::Pptx::Elements::NonvisualDrawingProperties.new.tap { |nvdp|
            nvdp.id = object_id % OpenXml::Pptx::MAX_ID_SIZE
            nvdp.name = "Picture"
          }
          nv_pic_property << OpenXml::Pptx::Elements::NonVisualPictrueDrawingProperties.new
          nv_pic_property << OpenXml::Pptx::Elements::NonvisualProperties.new
        }
      end

      def shape_property
        @shape_property = OpenXml::Pptx::Elements::ShapeProperties.new.tap { |sp|
          sp << OpenXml::DrawingML::Elements::TransformEffect.new.tap { |effect|
            effect << bounds
          }
          sp << OpenXml::DrawingML::Elements::PresetGeometry.new.tap { |preset_geometry|
            preset_geometry.preset = :rect
          }
        }
      end

      def blip_fill
        @blip_fill ||= OpenXml::Pptx::Elements::BlipFill.new.tap { |blip_fill|
          blip_fill << OpenXml::DrawingML::Elements::Blip.new.tap { |blip|
            blip.embed = relationship.id
          }
        }
      end
    end
  end
end
