--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:0656c3643d443464642ba5b04023f841:7e707995c54604df89bbac94bfbb1241:6d8e9616abb4eb7ae323588aedde5103$
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
            -- Cruise1-giga
            x=2,
            y=2,
            width=151,
            height=45,

        },
        {
            -- Cruise2-giga
            x=155,
            y=2,
            width=151,
            height=45,

        },
    },
    
    sheetContentWidth = 308,
    sheetContentHeight = 49
}

SheetInfo.frameIndex =
{

    ["Cruise1-giga"] = 1,
    ["Cruise2-giga"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
