module OpenXml
  module Pptx
    module Properties
      class Control < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        namespace :p
        tag :control

        attribute :control_name, displays_as: :name, expects: :string
        attribute :show_as_icon, displays_as: :showAsIcon, expects: :boolean
        attribute :rid, displays_as: :id, namespace: :r, expects: :string
        attribute :image_width, displays_as: :imgW, expects: :positive_coordinate
        attribute :image_height, displays_as: :imgH, expects: :positive_coordinate

        property :extension_list
        property :picture

      private

        def positive_coordinate(value)
          message = "Invalid: must be a positive integer or include a unit"
          raise ArgumentError, message unless positive_integer?(value) || positive_universal_measure?(value)
        end

        def positive_integer?(value)
          value.is_a?(Integer) && value >= 0
        end

        def positive_universal_measure?(value)
          value.is_a?(String) && value =~ OpenXml::DrawingML::ST_PositiveUniversalMeasure
        end

      end
    end
  end
end
