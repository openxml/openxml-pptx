module OpenXml
  module Pptx
    MAX_ID = 2**32 - 1
    SLIDE_ID_RANGE = (256...2_147_483_648)
    MASTER_LAYOUT_ID_RANGE = (2_147_483_648..MAX_ID)

    ST_SlideLayoutType = %i{ title tx twoColTx tbl txAndChart chartAndTx dgm
                             chart txAndClipArt clipArtAndTx titleOnly blank
                             txAndObj objAndTx objOnly obj txAndMedia mediaAndTx
                             objOverTx txOverObj txAndTwoObj twoObjAndTx twoObjOverTx
                             fourObj vertTx clipArtAndVertTx vertTitleAndTx
                             vertTitleAndTxOverChart twoObj objAndTwoObj
                             twoObjAndObj cust secHead twoTxTwoObj objTx picTx }.freeze


    # Part 1, 19.7.17
    ST_SlideSizeCoordinate = (914_400..51_206_400)

    # Part 1, 19.7.18
    ST_SlideSizeType = %i{ 35mm A3 A4 B4ISO B4JIS B5ISO B5JIS banner custom
                           hagakiCard ledger letter overhead screen16x10
                           screen16x9 screen4x3 }.freeze

    # Part 1, 19.7.10
    ST_PlaceholderType = %i{ title body ctrTitle subTitle dt sldNum ftr hdr obj
                             chart tbl clipArt dgm media sldImg pic }.freeze

    # Part 1, 19.7.9
    ST_PlaceholderSize = %i{ full half quarter }.freeze

    # Part 1, 19.7.2
    ST_Direction = %i{ horz vert }.freeze

    # Part 1, 19.7.8
    ST_PhotoAlbumLayout = %i{ 1pic 1picTitle 2pic 2picTitle 4pic 4picTitle fitToSlide }.freeze

    # Part 1, 19.7.7
    ST_PhotoAlbumFrameShape = (1..7).map { |num| :"frameStyle#{num}" }.freeze

    # Part 1, 20.1.10.10
    ST_BlackWhiteMode = %i{ clr auto gray ltGray invGray grayWhite blackGray
                            blackWhite black white hidden }.freeze

  end
end

require "openxml-drawingml"
require "openxml/pptx/version"
require "openxml/pptx/properties"
require "openxml/pptx/elements"
require "openxml/pptx/parts"
require "openxml/pptx/package"
