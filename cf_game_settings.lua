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
    countries["isreal"] = { 
        id = 26,
        name = "isreal",
        code = "bw",
        colors = {
            b = CFColor(0,56,184),
            w = CFColor(255,255,255)
        }
    }
    countries["italy"] = { 
        id = 27,
        name = "italy",
        code = "rgw",
        colors = {
            r = CFColor(206,43,55),
            g = CFColor(0,146,70),
            w = CFColor(255,255,255)
        }
    }
    countries["japan"] = { 
        id = 28,
        name = "japan",
        code = "rw",
        colors = {
            r = CFColor(188,0,45),
            w = CFColor(255,255,255)
        }
    }
    countries["lithuania"] = { 
        id = 29,
        name = "lithuania",
        code = "ryg",
        colors = {
            r = CFColor(139,39,45),
            y = CFColor(253,185,19),
            g = CFColor(0,106,68)
        }
    }
    countries["luxembourg"] = { 
        id = 30,
        name = "luxembourg",
        code = "rbw",
        colors = {
            r = CFColor(237,41,57),
            b = CFColor(0,161,222),
            w = CFColor(255,255,255)
        }
    }
    countries["malaysia"] = { 
        id = 31,
        name = "malaysia",
        code = "rybw",
        colors = {
            r = CFColor(204,0,1),
            y = CFColor(255,204,0),
            b = CFColor(1,0,102),
            w = CFColor(255,255,255)
        }
    }
    countries["malta"] = { 
        id = 32,
        name = "malta",
        code = "rw",
        colors = {
            r = CFColor(207,20,43),
            w = CFColor(255,255,255),
        }
    }
    countries["mexico"] = { 
        id = 33,
        name = "mexico",
        code = "rgw",
        colors = {
            r = CFColor(206,17,38),
            g = CFColor(0,104,71),
            w = CFColor(255,255,255)
        }
    }
    countries["netherland"] = { 
        id = 34,
        name = "netherland",
        code = "rbw",
        colors = {
            r = CFColor(174,28,40),
            b = CFColor(33,70,139),
            w = CFColor(255,255,255)
        }
    } 
    countries["newzealand"] = { 
        id = 35,
        name = "newzealand",
        code = "rbw",
        colors = {
            r = CFColor(204,20,43),
            b = CFColor(0,36,125),
            w = CFColor(255,255,255)
        }
    }
    countries["norway"] = { 
        id = 36,
        name = "norway",
        code = "rbw",
        colors = {
            r = CFColor(239,43,45),
            b = CFColor(0,40,104),
            w = CFColor(255,255,255)
        }
    }
    countries["philippines"] = { 
        id = 37,
        name = "philippines",
        code = "rybw",
        colors = {
            r = CFColor(206,17,38),
            y = CFColor(252,209,22),
            b = CFColor(0,56,168),
            w = CFColor(255,255,255)
        }
    }
    countries["poland"] = { 
        id = 38,
        name = "poland",
        code = "rw",
        colors = {
            r = CFColor(220,20,60),
            w = CFColor(255,255,255)
        }
    }
    countries["portugal"] = { 
        id = 39,
        name = "portugal",
        code = "rg",
        colors = {
            r = CFColor(255,0,0),
            g = CFColor(0,102,0)
        }
    }
    countries["russia"] = { 
        id = 40,
        name = "russia",
        code = "rbw",
        colors = {
            r = CFColor(213,43,30),
            b = CFColor(0,57,166),
            w = CFColor(255,255,255)
        }
    }
    countries["sanmarino"] = { 
        id = 41,
        name = "sanmarino",
        code = "bw",
        colors = {
            b = CFColor(94,182,228),
            w = CFColor(255,255,255)
        }
    }
    countries["singapore"] = { 
        id = 42,
        name = "singapore",
        code = "rw",
        colors = {
            r = CFColor(237,41,57),
            w = CFColor(255,255,255)
        }
    }
    countries["slovakia"] = { 
        id = 43,
        name = "slovakia",
        code = "rbw",
        colors = {
            r = CFColor(238,28,37),
            b = CFColor(11,78,162),
            w = CFColor(255,255,255)
        }
    }
    countries["slovenia"] = { 
        id = 44,
        name = "slovenia",
        code = "rbw",
        colors = {
            r = CFColor(237,28,36),
            b = CFColor(0,93,164),
            w = CFColor(255,255,255)
        }
    } 
    countries["southafrica"] = { 
        id = 45,
        name = "southafrica",
        code = "rygbwk",
        colors = {
            r = CFColor(222,56,49),
            y = CFColor(255,182,18),
            g = CFColor(0,122,77),
            g = CFColor(0,35,149),
            g = CFColor(255,255,255),
            k = CFColor(0,0,0)
        }
    }
    countries["southkorea"] = { 
        id = 46,
        name = "southkorea",
        code = "rbwk",
        colors = {
            r = CFColor(198,12,48),
            b = CFColor(0,52,120),
            w = CFColor(255,255,255),
            k = CFColor(0,0,0)
        }
    }
    countries["spain"] = { 
        id = 47,
        name = "spain",
        code = "ry",
        colors = {
            r = CFColor(198,11,30),
            y = CFColor(225,196,0)
        }
    }
    countries["srilanka"] = { 
        id = 48,
        name = "srilanka",
        code = "royg",
        colors = {
            r = CFColor(141,32,41),
            o = CFColor(255,91,0),
            y = CFColor(255,183,0),
            g = CFColor(0,86,65)
        }
    }
    countries["sweden"] = { 
        id = 49,
        name = "sweden",
        code = "yb",
        colors = {
            y = CFColor(255,183,0),
            b = CFColor(0,106,167)
        }
    }
    countries["switzerland"] = { 
        id = 50,
        name = "switzerland",
        code = "rw",
        colors = {
            r = CFColor(213,43,30),
            w = CFColor(255,255,255)
        }
    }
    countries["taiwan"] = { 
        id = 51,
        name = "taiwan",
        code = "rbw",
        colors = {
            r = CFColor(254,0,0),
            b = CFColor(0,0,149),
            w = CFColor(255,255,255)
        }
    }
    countries["thailand"] = { 
        id = 52,
        name = "thailand",
        code = "rbw",
        colors = {
            r = CFColor(237,28,36),
            b = CFColor(36,29,79),
            w = CFColor(255,255,255)
        }
    }
    countries["turkey"] = { 
        id = 53,
        name = "turkey",
        code = "rw",
        colors = {
            r = CFColor(227,10,23),
            w = CFColor(255,255,255)
        }
    }
    countries["unitedarabemirates"] = { 
        id = 54,
        name = "unitedarabemirates",
        code = "rgwk",
        colors = {
            r = CFColor(255,0,0),
            g = CFColor(0,115,47),
            y = CFColor(255,255,255),
            k = CFColor(0,0,0)
        }
    } 
    countries["unitedkingdom"] = { 
        id = 55,
        name = "unitedkingdom",
        code = "rbw",
        colors = {
            r = CFColor(207,20,43),
            b = CFColor(0,36,125),
            w = CFColor(255,255,255)
        }
    }
    countries["unitedstates"] = { 
        id = 56,
        name = "unitedstates",
        code = "rbw",
        colors = {
            r = CFColor(178,34,52),
            b = CFColor(60,59,110),
            w = CFColor(255,255,255)
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
