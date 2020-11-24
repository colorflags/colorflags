if string.sub(system.getInfo("model"),1,4) == "iPad" then
    application =
    {
        content =
        {
            width = 360,
            height = 480,
            scale = "letterBox",
            xAlign = "center",
            yAlign = "center",
            imageSuffix =
            {
                ["@2x"] = 1.5,
                ["@4x"] = 3.0,
            },
        },
        notification =
        {
            iphone = {
                types = {
                    "badge", "sound", "alert"
                }
            }
        }
    }
--iPhone 5 and up
elseif string.sub(system.getInfo("model"),1,2) == "iP" and display.pixelHeight > 960 then
    application =
    {
        content =
        {
            fps = 60,
            width = 320,
            height = 568,
            scale = "letterBox",
            xAlign = "center",
            yAlign = "center",
            imageSuffix =
            {
                ["@2x"] = 1.5, --iPhone 5 and iPhone6
                ["@4x"] = 3.0, --iPhone 6 Plus and up
            },
        },
        notification =
        {
            iphone = {
                types = {
                    "badge", "sound", "alert"
                }
            }
        }
    }
--iPhone 4
elseif string.sub(system.getInfo("model"),1,2) == "iP" then
    application =
    {
        content =
        {
            fps = 60,
            width = 320,
            height = 480,
            scale = "letterBox",
            xAlign = "center",
            yAlign = "center",
            imageSuffix =
            {
                ["@2x"] = 1.5, --iPhone 4
                ["@4x"] = 3.0,
            },
        },
        notification =
        {
            iphone = {
                types = {
                    "badge", "sound", "alert"
                }
            }
        }
    }
--Samsung Galaxy
elseif display.pixelHeight / display.pixelWidth > 1.72 and display.pixelHeight / display.pixelWidth < 2 then
    application =
    {
        content =
        {
            fps = 60,
            width = 360,
            height = 640,
            scale = "letterBox",
            xAlign = "center",
            yAlign = "center",
            imageSuffix =
            {
                ["@2x"] = 1.5, --Samsung Galaxy S3
                ["@4x"] = 3, -- Samsung Galaxy S5
            },
        },
    }
elseif display.pixelHeight / display.pixelWidth >= 2 then
    application =
    {
        content =
        {
            fps = 60,
            width = 360,
            height = 720,
            scale = "letterBox",
            xAlign = "center",
            yAlign = "center",
            imageSuffix =
            {
                ["@2x"] = 1.5, -- i don't know LOL
                ["@4x"] = 3, -- OnePlus 5T
            },
        },
    }
else
    application =
    {
        content =
        {
            width = 320,
            height = 512,
            scale = "letterBox",
            xAlign = "center",
            yAlign = "center",
            imageSuffix =
            {
                ["@2x"] = 1.5,
                ["@4x"] = 3.0,
            },
        },
        notification =
        {
            iphone = {
                types = {
                    "badge", "sound", "alert"
                }
            }
        }
    }
end
