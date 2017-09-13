require "spec_helper"

describe OpenXml::Pptx::Properties::Font do
  include ValuePropertyTestMacros

  it_should_use tag: :font, name: "font", value: "Calibri"

  with_value("Calibri") do
    it_should_work
    it_should_output "<p:font typeface=\"Calibri\"/>"
  end

  with_value(:not_a_string) do
    it_should_not_work
  end
end
