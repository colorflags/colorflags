--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:313af80d5c474f58e96e1c8cec16562e:249ce44904dfbf7836181853213d0d55:d7cd3a0e434ae00c7840f22618641acf$
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
            -- just_clouds_fg3
            x=0,
            y=0,
            width=570,
            height=360,

        },
    },
    
    sheetContentWidth = 570,
    sheetContentHeight = 360
}

SheetInfo.frameIndex =
{

    ["just_clouds_fg3"] = 1,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
