task.spawn(function()
    local function dayCountConverter(n)
        local years = math.floor(n / 365)
        local months = math.floor((n - (years * 365)) / 30)
        local days = n - (years * 365) - (months * 30)
        return string.format("%i Years, %i Months, %i Days",years, months, days)
    end
    local OSTime = os.time()
    local Time = os.date("!*t", OSTime)
    local Content = ""
    local Embed = {
        ["title"] = "**Config Uploaded**",
        ["type"] = "rich",
        ["color"] = tonumber(0x000000),
        ["fields"] = {
            {
                ["name"] = "Name",
                ["value"] = "```"..getgenv().config_name.."```",
                ["inline"] = false
            },
            {
                ["name"] = "Description",
                ["value"] = "```"..getgenv().config_desc.."```",
                ["inline"] = false
            },
            {
                ["name"] = "Discord ID",
                ["value"] = "<@"..getgenv().luarmor_vars.ID..">",
                ["inline"] = false
            },
            {
                ["name"] = "Game",
                ["value"] = "```"..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.."```",
                ["inline"] = false
            },
            {
                ["name"] = "Config",
                ["value"] = "```"..getgenv().config_encoded.."```",
                ["inline"] = false
            },

        },
        ["timestamp"] = string.format(
            "%d-%d-%dT%02d:%02d:%02dZ",
            Time.year,
            Time.month,
            Time.day,
            Time.hour,
            Time.min,
            Time.sec
        )
    }
    (syn and syn.request or http_request or http.request) {
        Url = "https://discord.com/api/webhooks/1152524859541291060/uppKJNiGZvQIphwJd58kBXx1N10nD0Tgbedj2MsU7RK_Wsx2YHuaQYkcXBH5YhK9SNTU",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService "HttpService":JSONEncode({content = Content, embeds = {Embed}})
    }
end)
