# frozen_string_literals: true
require "openxml/elements/notes_size"
require "openxml/elements/slide_size"

module OpenXml
  module Pptx
    module Parts
      class Theme < OpenXml::Part
        attr_accessor :relationships
        private :relationships=

        def initialize
          self.relationships = OpenXml::Parts::Rels.new
        end

        def add_relationship(type, target)
          relationships.add_relationship(type, target)
        end

        def add_to(ancestors)
          parent, *rest = ancestors
          parent.add_part rest, "theme/themeBasic.xml", self
          parent.add_override rest, "theme/themeBasic.xml", "application/vnd.openxmlformats-officedocument.theme+xml"

          parent.add_relationship "http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme", "/ppt/theme/themeBasic.xml"
        end

        def relationship_type
          "http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme"
        end


        def relationship_target
          "/ppt/theme/themeBasic.xml"
        end

        def to_xml
          xml = <<~XML
          <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
          <a:theme xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" name="Office Theme">
            <a:themeElements>
              <a:clrScheme name="Office">
                <a:dk1>
                  <a:sysClr val="windowText" lastClr="000000"/>
                </a:dk1>
                <a:lt1>
                  <a:sysClr val="window" lastClr="FFFFFF"/>
                </a:lt1>
                <a:dk2>
                  <a:srgbClr val="44546A"/>
                </a:dk2>
                <a:lt2>
                  <a:srgbClr val="E7E6E6"/>
                </a:lt2>
                <a:accent1>
                  <a:srgbClr val="4472C4"/>
                </a:accent1>
                <a:accent2>
                  <a:srgbClr val="ED7D31"/>
                </a:accent2>
                <a:accent3>
                  <a:srgbClr val="A5A5A5"/>
                </a:accent3>
                <a:accent4>
                  <a:srgbClr val="FFC000"/>
                </a:accent4>
                <a:accent5>
                  <a:srgbClr val="5B9BD5"/>
                </a:accent5>
                <a:accent6>
                  <a:srgbClr val="70AD47"/>
                </a:accent6>
                <a:hlink>
                  <a:srgbClr val="0563C1"/>
                </a:hlink>
                <a:folHlink>
                  <a:srgbClr val="954F72"/>
                </a:folHlink>
              </a:clrScheme>
              <a:fontScheme name="Office">
                <a:majorFont>
                  <a:latin typeface="Calibri Light"/>
                  <a:ea typeface=""/>
                  <a:cs typeface=""/>
                </a:majorFont>
                <a:minorFont>
                  <a:latin typeface="Calibri"/>
                  <a:ea typeface=""/>
                  <a:cs typeface=""/>
                </a:minorFont>
              </a:fontScheme>
              <a:fmtScheme name="Office">
                <a:fillStyleLst>
                  <a:noFill/>
                  <a:noFill/>
                  <a:noFill/>
                </a:fillStyleLst>
                <a:lnStyleLst>
                  <a:ln/>
                  <a:ln/>
                  <a:ln/>
                </a:lnStyleLst>
                <a:effectStyleLst>
                  <a:effectStyle>
                    <a:effectLst/>
                  </a:effectStyle>
                  <a:effectStyle>
                    <a:effectLst/>
                  </a:effectStyle>
                  <a:effectStyle>
                    <a:effectLst/>
                  </a:effectStyle>
                </a:effectStyleLst>
                <a:bgFillStyleLst>
                  <a:noFill/>
                  <a:noFill/>
                  <a:noFill/>
                </a:bgFillStyleLst>
              </a:fmtScheme>
            </a:themeElements>
          </a:theme>
          XML
          def xml.to_s(*args)
            self
          end
          xml
        end
      end
    end
  end
end
