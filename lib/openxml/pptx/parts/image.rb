module OpenXml
  module Pptx
    module Parts
      class Image < OpenXml::Parts::UnparsedPart
        attr_reader :path, :content_type, :relationship_type

        def initialize(*args, extension: ".png")
          super(*args)
          @path = Pathname.new("ppt/media/image#{extension}")
          @content_type = IMAGE_TYPES.fetch(extension)
          @relationship_type = IMAGE_RELATIONSHIP_TYPE
        end

        def path=(value)
          @path = Pathname.new(value)
        end

        IMAGE_RELATIONSHIP_TYPE = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/image".freeze

        IMAGE_TYPES = {
          ".jpeg" => "image/jpeg",
          ".jpg" => "image/jpeg",
          ".png" => "image/png",
          ".gif" => "image/gif",
          ".bmp" => "image/bmp",
          ".tiff" => "image/tiff",
          ".jxr" => "image/vnd.ms-photo"
        }.freeze

      end
    end
  end
end
