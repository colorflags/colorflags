--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:2e543bbb2b4e302b1e84603577a5f2a8:64919f971a530045a2b0767a54f09044:554b6f30c2802724c779208ee0f94411$
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
            -- Tutorial1
            x=4,
            y=4,
            width=282,
            height=68,

        },
        {
            -- Tutorial2
            x=290,
            y=4,
            width=282,
            height=68,

        },
        {
            -- Tutorial3
            x=4,
            y=76,
            width=282,
            height=68,

        },
        {
            -- Tutorial4
            x=290,
            y=76,
            width=282,
            height=68,

        },
    },
    
    sheetContentWidth = 576,
    sheetContentHeight = 150
}

SheetInfo.frameIndex =
{

    ["Tutorial1"] = 1,
    ["Tutorial2"] = 2,
    ["Tutorial3"] = 3,
    ["Tutorial4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
