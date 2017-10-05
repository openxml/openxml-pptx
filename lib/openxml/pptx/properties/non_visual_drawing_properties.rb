module OpenXml
  module Pptx
    module Properties
      class NonVisualDrawingProperties < OpenXml::Properties::ComplexProperty
        include OpenXml::ContainsProperties
        include OpenXml::RenderWhenEmpty
        namespace :p
        tag :cNvPr

        attribute :description, displays_as: :descr, expects: :string
        attribute :hidden, expects: :boolean
        attribute :id, expects: :positive_integer, required: true
        attribute :object_name, displays_as: :name, expects: :string_or_blank, required: true
        attribute :title, expects: :string

        property :hyperlink_click, klass: OpenXml::DrawingML::Properties::HyperlinkClick
        property :hyperlink_hover, klass: OpenXml::DrawingML::Properties::HyperlinkHover

        property :extension_list, klass: OpenXml::DrawingML::Properties::ExtensionList

        def build_required_properties
          super
          self.object_name ||= ""
          self.id ||= object_id % OpenXml::Pptx::MAX_ID
        end

      end
    end
  end
end
