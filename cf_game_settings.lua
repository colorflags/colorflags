require("class")
require("cf_color")

CFGameSettings = class(function(c)
    
    local countries = {}
    countries["andorra"] = { 
        id = 1,
        name = "andorra",
        code = "ryb",
        colors = {
            r = CFColor(208,16,58),
            y = CFColor(254,223,0),
            b = CFColor(0,24,168)
        },
        coords = { x = 350, y = 442 }
    }
    countries["argentina"] = { 
        id = 2,
        name = "argentina",
        code = "bw",
        colors = {
            b = CFColor(116,172,223),
            w = CFColor(255,255,255),
        },
    }
    countries["australia"] = { 
        id = 3,
        name = "australia",
        code = "rbw",
        colors = {
            r = CFColor(255,0,0),
            b = CFColor(0,4,139),
            w = CFColor(255,255,255)
        }
    } 
    countries["australia"] = { 
        id = 4,
        name = "australia",
        code = "rw",
        colors = {
            r = CFColor(237,41,57),
            w = CFColor(255,255,255),
        }
    }
    countries["belgium"] = { 
        id = 5,
        name = "belgium",
        code = "ryk",
        colors = {
            r = CFColor(237,41,57),
            y = CFColor(250,224,66),
            k = CFColor(0,0,0)
        }
    }
    countries["brazil"] = { 
        id = 6,
        name = "brazil",
        code = "ygbw",
        colors = {
            y = CFColor(254,233,0),
            g = CFColor(0,155,58),
            b = CFColor(0,39,118),
            w = CFColor(255,255,255)
        }
    }
    countries["canada"] = { 
        id = 7,
        name = "canada",
        code = "rw",
        colors = {
            r = CFColor(255,0,0),
            w = CFColor(255,255,255)
        }
    }
    countries["chile"] = { 
        id = 8,
        name = "chile",
        code = "rbw",
        colors = {
            r = CFColor(213,43,30),
            b = CFColor(0,57,166),
            w = CFColor(255,255,255)
        }
    }
    countries["china"] = { 
        id = 9,
        name = "china",
        code = "ry",
        colors = {
            r = CFColor(213,43,30),
            y = CFColor(255,222,0)
        }
    }
    countries["croatia"] = { 
        id = 10,
        name = "croatia",
        code = "rbw",
        colors = {
            r = CFColor(255,0,0),
            b = CFColor(23,23,150),
            w = CFColor(255,255,255)
        }
    }
    countries["cypress"] = { 
        id = 11,
        name = "cypress",
        code = "ogw",
        colors = {
            o = CFColor(216,217,3),
            g = CFColor(47,71,18),
            w = CFColor(255,255,255)
        }
    }
    countries["czechrepublic"] = { 
        id = 12,
        name = "czechrepublic",
        code = "bw",
        colors = {
            b = CFColor(17,69,126),
            w = CFColor(255,255,255)
        }
    }
    countries["denmark"] = { 
        id = 13,
        name = "denmark",
        code = "rw",
        colors = {
            r = CFColor(215,20,26),
            w = CFColor(255,255,255)
        }
    } 
    countries["egypt"] = { 
        id = 14,
        name = "egypt",
        code = "rw",
        colors = {
            r = CFColor(206,17,38),
            w = CFColor(255,255,255)
        }
    }
    countries["estonia"] = { 
        id = 15,
        name = "estonia",
        code = "bw",
        colors = {
            b = CFColor(72,145,217),
            w = CFColor(255,255,255)
        }
    }
    countries["finland"] = { 
        id = 16,
        name = "finland",
        code = "bw",
        colors = {
            = CFColor(0,53,128),
            = CFColor(255,255,255)
        }
    }
    countries["france"] = { 
        id = 18,
        name = "france",
        code = "rbw",
        colors = {
            r = CFColor(237,41,57),
            b = CFColor(0,35,149),
            w = CFColor(255,255,255)
        }
    }
    countries["germany"] = { 
        id = 19,
        name = "germany",
        code = "ryk",
        colors = {
            r = CFColor(221,0,0),
            y = CFColor(255,206,0),
            k = CFColor(0,0,0)
        }
    }
    countries["greece"] = { 
        id = 20,
        name = "greece",
        code = "bw",
        colors = {
            b = CFColor(13,94,175),
            w = CFColor(255,255,255)
        }
    }
    countries["hungary"] = { 
        id = 21,
        name = "hungary",
        code = "rgw",
        colors = {
            r = CFColor(205,42,62),
            g = CFColor(67,111,77),
            w = CFColor(255,255,255)
        }
    }
    countries["iceland"] = { 
        id = 22,
        name = "iceland",
        code = "rbw",
        colors = {
            r = CFColor(215,40,40),
            b = CFColor(0,56,151),
            w = CFColor(255,255,255)
        }
    }
    countries["india"] = { 
        id = 23,
        name = "india",
        code = "ogbw",
        colors = {
            o = CFColor(255,153,51),
            g = CFColor(18,136,7),
            b = CFColor(0,0,0),
            w = CFColor(255,255,255)
        }
    }
    countries["indonesia"] = { 
        id = 24,
        name = "indonesia",
        code = "rw",
        colors = {
            r = CFColor(206,17,38),
            w = CFColor(255,255,255)
        }
    } 
    countries["ireland"] = { 
        id = 25,
        name = "ireland",
        code = "ogw",
        colors = {
            o = CFColor(255,121,0),
            g = CFColor(0,155,72),
            w = CFColor(255,255,255)
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    } 
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    } 
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    } 
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    } 
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    countries[""] = { 
        id = 1,
        name = "",
        code = "",
        colors = {
            = CFColor(),
            = CFColor(),
            = CFColor()
        }
    }
    
    
    c.countries = countries
    print("working here:", #countries)
end)
--[[
function BulbGameSettings:getItemByID(id)
    for k, v in pairs(self.countries) do
        if (v.id == id) then
            return v
        end
    end
end

function BulbGameSettings:getItemByName(name)
    return self.countries[name]
end
]]--
