require("class")
require("cf_color")

CFGameSettings = class(function(c)
    local countries = {}
    countries["Andorra"] = { 
        id = 1,
        name = "Andorra",
        code = "ryb",
        colors = {
            r = CFColor(208,16,58),
            y = CFColor(254,223,0),
            b = CFColor(0,24,168)
        },
        coords = { x = 350, y = 442 }
    }
    countries["Argentina"] = { 
        id = 2,
        name = "Argentina",
        code = "bw",
        colors = {
            b = CFColor(116,172,223),
            w = CFColor(255,255,255),
        },
    }
    countries["Australia"] = { 
        id = 3,
        name = "Australia",
        code = "rbw",
        colors = {
            r = CFColor(255,0,0),
            b = CFColor(0,4,139),
            w = CFColor(255,255,255)
        }
    } 
    countries["Austria"] = { 
        id = 4,
        name = "Austria",
        code = "rw",
        colors = {
            r = CFColor(237,41,57),
            w = CFColor(255,255,255),
        }
    }
    countries["Belgium"] = { 
        id = 5,
        name = "Belgium",
        code = "ryk",
        colors = {
            r = CFColor(237,41,57),
            y = CFColor(250,224,66),
            k = CFColor(0,0,0)
        }
    }
    countries["Brazil"] = { 
        id = 6,
        name = "Brazil",
        code = "ygbw",
        colors = {
            y = CFColor(254,233,0),
            g = CFColor(0,155,58),
            b = CFColor(0,39,118),
            w = CFColor(255,255,255)
        }
    }
    countries["Canada"] = { 
        id = 7,
        name = "Canada",
        code = "rw",
        colors = {
            r = CFColor(255,0,0),
            w = CFColor(255,255,255)
        }
    }
    countries["Chile"] = { 
        id = 8,
        name = "Chile",
        code = "rbw",
        colors = {
            r = CFColor(213,43,30),
            b = CFColor(0,57,166),
            w = CFColor(255,255,255)
        }
    }
    countries["China"] = { 
        id = 9,
        name = "China",
        code = "ry",
        colors = {
            r = CFColor(213,43,30),
            y = CFColor(255,222,0)
        }
    }
    countries["Croatia"] = { 
        id = 10,
        name = "Croatia",
        code = "rbw",
        colors = {
            r = CFColor(255,0,0),
            b = CFColor(23,23,150),
            w = CFColor(255,255,255)
        }
    }
    countries["Cypress"] = { 
        id = 11,
        name = "Cypress",
        code = "ogw",
        colors = {
            o = CFColor(216,217,3),
            g = CFColor(47,71,18),
            w = CFColor(255,255,255)
        }
    }
    countries["CzechRepublic"] = { 
        id = 12,
        name = "CzechRepublic",
        code = "bw",
        colors = {
            b = CFColor(17,69,126),
            w = CFColor(255,255,255)
        }
    }
    countries["Denmark"] = { 
        id = 13,
        name = "Denmark",
        code = "rw",
        colors = {
            r = CFColor(215,20,26),
            w = CFColor(255,255,255)
        }
    } 
    countries["Egypt"] = { 
        id = 14,
        name = "Egypt",
        code = "rw",
        colors = {
            r = CFColor(206,17,38),
            w = CFColor(255,255,255)
        }
    }
    countries["Estonia"] = { 
        id = 15,
        name = "Estonia",
        code = "bw",
        colors = {
            b = CFColor(72,145,217),
            w = CFColor(255,255,255)
        }
    }
    countries["Finland"] = { 
        id = 16,
        name = "Finland",
        code = "bw",
        colors = {
            b = CFColor(0,53,128),
            w = CFColor(255,255,255)
        }
    }
    countries["France"] = { 
        id = 18,
        name = "France",
        code = "rbw",
        colors = {
            r = CFColor(237,41,57),
            b = CFColor(0,35,149),
            w = CFColor(255,255,255)
        }
    }
    countries["Germany"] = { 
        id = 19,
        name = "Germany",
        code = "ryk",
        colors = {
            r = CFColor(221,0,0),
            y = CFColor(255,206,0),
            k = CFColor(0,0,0)
        }
    }
    countries["Greece"] = { 
        id = 20,
        name = "Greece",
        code = "bw",
        colors = {
            b = CFColor(13,94,175),
            w = CFColor(255,255,255)
        }
    }
    countries["Hungary"] = { 
        id = 21,
        name = "Hungary",
        code = "rgw",
        colors = {
            r = CFColor(205,42,62),
            g = CFColor(67,111,77),
            w = CFColor(255,255,255)
        }
    }
    countries["Iceland"] = { 
        id = 22,
        name = "Iceland",
        code = "rbw",
        colors = {
            r = CFColor(215,40,40),
            b = CFColor(0,56,151),
            w = CFColor(255,255,255)
        }
    }
    countries["India"] = { 
        id = 23,
        name = "India",
        code = "ogbw",
        colors = {
            o = CFColor(255,153,51),
            g = CFColor(18,136,7),
            b = CFColor(0,0,0),
            w = CFColor(255,255,255)
        }
    }
    countries["Indonesia"] = { 
        id = 24,
        name = "Indonesia",
        code = "rw",
        colors = {
            r = CFColor(206,17,38),
            w = CFColor(255,255,255)
        }
    } 
    countries["Ireland"] = { 
        id = 25,
        name = "Ireland",
        code = "ogw",
        colors = {
            o = CFColor(255,121,0),
            g = CFColor(0,155,72),
            w = CFColor(255,255,255)
        }
    }
    countries["Isreal"] = { 
        id = 26,
        name = "Isreal",
        code = "bw",
        colors = {
            b = CFColor(0,56,184),
            w = CFColor(255,255,255)
        }
    }
    countries["Italy"] = { 
        id = 27,
        name = "Italy",
        code = "rgw",
        colors = {
            r = CFColor(206,43,55),
            g = CFColor(0,146,70),
            w = CFColor(255,255,255)
        }
    }
    countries["Japan"] = { 
        id = 28,
        name = "Japan",
        code = "rw",
        colors = {
            r = CFColor(188,0,45),
            w = CFColor(255,255,255)
        }
    }
    countries["Lithuania"] = { 
        id = 29,
        name = "Lithuania",
        code = "ryg",
        colors = {
            r = CFColor(139,39,45),
            y = CFColor(253,185,19),
            g = CFColor(0,106,68)
        }
    }
    countries["Luxembourg"] = { 
        id = 30,
        name = "Luxembourg",
        code = "rbw",
        colors = {
            r = CFColor(237,41,57),
            b = CFColor(0,161,222),
            w = CFColor(255,255,255)
        }
    }
    countries["Malaysia"] = { 
        id = 31,
        name = "Malaysia",
        code = "rybw",
        colors = {
            r = CFColor(204,0,1),
            y = CFColor(255,204,0),
            b = CFColor(1,0,102),
            w = CFColor(255,255,255)
        }
    }
    countries["Malta"] = { 
        id = 32,
        name = "Malta",
        code = "rw",
        colors = {
            r = CFColor(207,20,43),
            w = CFColor(255,255,255),
        }
    }
    countries["Mexico"] = { 
        id = 33,
        name = "Mexico",
        code = "rgw",
        colors = {
            r = CFColor(206,17,38),
            g = CFColor(0,104,71),
            w = CFColor(255,255,255)
        }
    }
    countries["Netherland"] = { 
        id = 34,
        name = "Netherland",
        code = "rbw",
        colors = {
            r = CFColor(174,28,40),
            b = CFColor(33,70,139),
            w = CFColor(255,255,255)
        }
    } 
    countries["NewZealand"] = { 
        id = 35,
        name = "NewZealand",
        code = "rbw",
        colors = {
            r = CFColor(204,20,43),
            b = CFColor(0,36,125),
            w = CFColor(255,255,255)
        }
    }
    countries["Norway"] = { 
        id = 36,
        name = "Norway",
        code = "rbw",
        colors = {
            r = CFColor(239,43,45),
            b = CFColor(0,40,104),
            w = CFColor(255,255,255)
        }
    }
    countries["Philippines"] = { 
        id = 37,
        name = "Philippines",
        code = "rybw",
        colors = {
            r = CFColor(206,17,38),
            y = CFColor(252,209,22),
            b = CFColor(0,56,168),
            w = CFColor(255,255,255)
        }
    }
    countries["Poland"] = { 
        id = 38,
        name = "Poland",
        code = "rw",
        colors = {
            r = CFColor(220,20,60),
            w = CFColor(255,255,255)
        }
    }
    countries["Portugal"] = { 
        id = 39,
        name = "Portugal",
        code = "rg",
        colors = {
            r = CFColor(255,0,0),
            g = CFColor(0,102,0)
        }
    }
    countries["Russia"] = { 
        id = 40,
        name = "Russia",
        code = "rbw",
        colors = {
            r = CFColor(213,43,30),
            b = CFColor(0,57,166),
            w = CFColor(255,255,255)
        }
    }
    countries["SanMarino"] = { 
        id = 41,
        name = "SanMarino",
        code = "bw",
        colors = {
            b = CFColor(94,182,228),
            w = CFColor(255,255,255)
        }
    }
    countries["Singapore"] = { 
        id = 42,
        name = "Singapore",
        code = "rw",
        colors = {
            r = CFColor(237,41,57),
            w = CFColor(255,255,255)
        }
    }
    countries["Slovakia"] = { 
        id = 43,
        name = "Slovakia",
        code = "rbw",
        colors = {
            r = CFColor(238,28,37),
            b = CFColor(11,78,162),
            w = CFColor(255,255,255)
        }
    }
    countries["Slovenia"] = { 
        id = 44,
        name = "Slovenia",
        code = "rbw",
        colors = {
            r = CFColor(237,28,36),
            b = CFColor(0,93,164),
            w = CFColor(255,255,255)
        }
    } 
    countries["SouthAfrica"] = { 
        id = 45,
        name = "southafrica",
        code = "rygbwk",
        colors = {
            r = CFColor(222,56,49),
            y = CFColor(255,182,18),
            g = CFColor(0,122,77),
            b = CFColor(0,35,149),
            w = CFColor(255,255,255),
            k = CFColor(0,0,0)
        }
    }
    countries["SouthKorea"] = { 
        id = 46,
        name = "SouthKorea",
        code = "rbwk",
        colors = {
            r = CFColor(198,12,48),
            b = CFColor(0,52,120),
            w = CFColor(255,255,255),
            k = CFColor(0,0,0)
        }
    }
    countries["Spain"] = { 
        id = 47,
        name = "Spain",
        code = "ry",
        colors = {
            r = CFColor(198,11,30),
            y = CFColor(225,196,0)
        }
    }
    countries["SriLanka"] = { 
        id = 48,
        name = "SriLanka",
        code = "royg",
        colors = {
            r = CFColor(141,32,41),
            o = CFColor(255,91,0),
            y = CFColor(255,183,0),
            g = CFColor(0,86,65)
        }
    }
    countries["Sweden"] = { 
        id = 49,
        name = "Sweden",
        code = "yb",
        colors = {
            y = CFColor(255,183,0),
            b = CFColor(0,106,167)
        }
    }
    countries["Switzerland"] = { 
        id = 50,
        name = "Switzerland",
        code = "rw",
        colors = {
            r = CFColor(213,43,30),
            w = CFColor(255,255,255)
        }
    }
    countries["Taiwan"] = { 
        id = 51,
        name = "Taiwan",
        code = "rbw",
        colors = {
            r = CFColor(254,0,0),
            b = CFColor(0,0,149),
            w = CFColor(255,255,255)
        }
    }
    countries["Thailand"] = { 
        id = 52,
        name = "Thailand",
        code = "rbw",
        colors = {
            r = CFColor(237,28,36),
            b = CFColor(36,29,79),
            w = CFColor(255,255,255)
        }
    }
    countries["Turkey"] = { 
        id = 53,
        name = "Turkey",
        code = "rw",
        colors = {
            r = CFColor(227,10,23),
            w = CFColor(255,255,255)
        }
    }
    countries["UnitedArabEmirates"] = { 
        id = 54,
        name = "UnitedArabEmirates",
        code = "rgwk",
        colors = {
            r = CFColor(255,0,0),
            g = CFColor(0,115,47),
            y = CFColor(255,255,255),
            k = CFColor(0,0,0)
        }
    } 
    countries["UnitedKingdom"] = { 
        id = 55,
        name = "UnitedKingdom",
        code = "rbw",
        colors = {
            r = CFColor(207,20,43),
            b = CFColor(0,36,125),
            w = CFColor(255,255,255)
        }
    }
    countries["UnitedStates"] = { 
        id = 56,
        name = "UnitedStates",
        code = "rbw",
        colors = {
            r = CFColor(178,34,52),
            b = CFColor(60,59,110),
            w = CFColor(255,255,255)
        }
    }
    
    c.countries = countries
end)

function CFGameSettings:getItemByID(id)
    for k, v in pairs(self.countries) do
        if (v.id == id) then
            return v
        end
    end
end

--[[
function BulbGameSettings:getItemByName(name)
    return self.countries[name]
end
]]--
