module OpenXml
  module Pptx
    module Properties
    end
  end
end

require "openxml/properties"
require "openxml/has_properties"
require "openxml/has_children"
require "openxml/has_attributes"
require "openxml/contains_properties"
require "openxml/render_when_empty"

require "openxml/pptx/properties/simple_boolean_property"
require "openxml/pptx/properties/simple_property_container_property"
require "openxml/pptx/properties/transparent_container_property"

Dir.glob("#{File.join(File.dirname(__FILE__), "properties", "*.rb")}").each do |file|
  require file
end
