--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:f2b992ab773c6ab6ea84f6bff73825bd:e99b35244507a12b338e1047db6ee0af:de682786e8ec15b0a9d917eeef86fd33$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- 1
            x=2,
            y=2,
            width=580,
            height=168,

        },
        {
            -- 2
            x=2,
            y=172,
            width=580,
            height=168,

        },
        {
            -- 3
            x=2,
            y=342,
            width=580,
            height=168,

        },
        {
            -- 4
            x=584,
            y=2,
            width=580,
            height=168,

        },
        {
            -- 5
            x=1166,
            y=2,
            width=580,
            height=168,

        },
        {
            -- 6
            x=584,
            y=172,
            width=580,
            height=168,

        },
        {
            -- 7
            x=1166,
            y=172,
            width=580,
            height=168,

        },
        {
            -- 8
            x=584,
            y=342,
            width=580,
            height=168,

        },
    },
    
    sheetContentWidth = 1748,
    sheetContentHeight = 512
}

SheetInfo.frameIndex =
{

    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
