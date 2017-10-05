module OpenXml
  module Pptx
    module Properties
      class PhotoAlbum < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        namespace :p
        tag :photoAlbum

        attribute :black_and_white, displays_as: :bw, expects: :boolean
        attribute :frame, one_of: OpenXml::Pptx::ST_PhotoAlbumFrameShape
        attribute :layout, one_of: OpenXml::Pptx::ST_PhotoAlbumLayout
        attribute :show_captions, expects: :boolean

        property :extension_list

      end
    end
  end
end
