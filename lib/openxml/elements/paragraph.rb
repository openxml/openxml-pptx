module OpenXml
  module Elements
    class Paragraph < Element
      include HasChildren

      namespace :a
      tag :p

    end
  end
end
