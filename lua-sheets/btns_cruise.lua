--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:7d82446de6afb6841123e168796c840d:229dbed94989e2c3f6d949ce3b0d15e8:a1db3c08425829f8d2ae39e343992c72$
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
            -- Cruise1
            x=2,
            y=2,
            width=116,
            height=34,

        },
        {
            -- Cruise2
            x=120,
            y=2,
            width=116,
            height=34,

        },
    },
    
    sheetContentWidth = 238,
    sheetContentHeight = 38
}

SheetInfo.frameIndex =
{

    ["Cruise1"] = 1,
    ["Cruise2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
