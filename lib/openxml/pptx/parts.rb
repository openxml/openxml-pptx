module OpenXml
  module Pptx
    module Parts
    end
  end
end

require "openxml/pptx/relatable_part"
require "openxml/parts"
Dir.glob("#{File.join(File.dirname(__FILE__), "parts", "*.rb")}").each do |file|
  require file
end
