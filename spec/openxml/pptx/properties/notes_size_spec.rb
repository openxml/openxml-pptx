require "spec_helper"

describe OpenXml::Pptx::Properties::NotesSize do
  include PropertyTestMacros

  it_should_use tag: :notesSz, name: "notes_size"

  %i{ length width }.each do |dimension|
    for_attribute(dimension) do
      with_value(1_000_000) do
        it_should_assign_successfully
        it_should_output_expected_xml
      end

      [-1, :invalid].each do |bad_value|
        with_value(bad_value) do
          it_should_raise_an_exception
        end
      end
    end
  end
end
