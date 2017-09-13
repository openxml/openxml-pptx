module OpenXml
  module Pptx
    module Properties
      class BackgroundProperties < OpenXml::Properties::ComplexProperty
        include ContainsProperties
        namespace :p
        tag :bgPr

        attribute :shade_to_title, displays_as: :shadeToTitle, expects: :boolean

        property_choice do
          value_property :no_fill, klass: OpenXml::DrawingML::Properties::FillNone
          property :solid_fill, klass: OpenXml::DrawingML::Properties::FillSolid
          property :gradient_fill, klass: OpenXml::DrawingML::Properties::FillGradient
          property :pattern_fill, klass: OpenXml::DrawingML::Properties::FillPattern
          property :blip_fill, klass: OpenXml::DrawingML::Properties::FillBlip
          value_property :inherit_group_fill, klass: OpenXml::DrawingML::Properties::FillGroup
        end

        property_choice do
          property :effect_list, klass: OpenXml::DrawingML::Properties::EffectList
          property :effect_dag, klass: OpenXml::DrawingML::Properties::EffectDag
        end

        property :extension_list

      end
    end
  end
end
