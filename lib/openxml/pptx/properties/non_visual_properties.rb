module OpenXml
  module Pptx
    module Properties
      class NonVisualProperties < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        include OpenXml::RenderWhenEmpty
        namespace :p
        tag :nvPr

        attribute :is_photo, displays_as: :isPhoto, expects: :boolean
        attribute :user_drawn, displays_as: :userDrawn, expects: :boolean

        property :placeholder

        property_choice do
          property :audio_cd, klass: OpenXml::DrawingML::Properties::AudioCd
          property :wav_audio_file, klass: OpenXml::DrawingML::Properties::WavAudioFile
          property :audio_file, klass: OpenXml::DrawingML::Properties::AudioFile
          property :video_file, klass: OpenXml::DrawingML::Properties::VideoFile
          property :quick_time_file, klass: OpenXml::DrawingML::Properties::QuickTimeFile
        end

        property :customer_data_list
        property :extension_list

      end
    end
  end
end
