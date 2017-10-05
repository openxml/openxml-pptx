module OpenXml
  module Pptx
    module Properties
      class SimpleBooleanProperty < OpenXml::Properties::BooleanProperty

        def to_xml(xml)
          return unless value
          apply_namespace(xml).public_send(tag) do
            yield xml if block_given?
          end
        end

      end
    end
  end
end
