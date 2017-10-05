module OpenXml
  module Pptx
    module Elements
    end
  end
end

require "openxml/has_children"
require "openxml/element"
Dir.glob("#{File.join(File.dirname(__FILE__), "elements", "*.rb")}").each do |file|
  require file
end
