module OpenXml
  module Pptx
    module Properties
      class GroupShapeProperties < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        include OpenXml::RenderWhenEmpty
        namespace :p
        tag :grpSpPr

        attribute :bw_mode, one_of: OpenXml::Pptx::ST_BlackWhiteMode

        property :transform, klass: OpenXml::DrawingML::Properties::GroupTransform

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

        property :scene_3d, klass: OpenXml::DrawingML::Properties::Scene3d
        property :extension_list, klass: OpenXml::DrawingML::Properties::ExtensionList

      end
    end
  end
end
