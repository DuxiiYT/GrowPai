-- webhook here
local webhookURL = ""

local function logonconsolemessage(content, thumbnailURL)
    content = content:gsub('"', '\\"')

    local current_datetime = os.date("%A, %Y/%m/%d at %I:%M %p")
    return [[{
        "embeds": [{
            "description": "**]] .. content .. [[**",
            "thumbnail": {
                "url": "]] .. thumbnailURL .. [["
            },
            "footer": {
                "text": "]] .. current_datetime .. [["
            }
        }]
    }]]
end

local function handler(varlist, keyword, thumbnailURL)
    if varlist[0] == "OnConsoleMessage" and varlist[1]:find(keyword) then
        local message = varlist[1]
        local modifiedMessage = message:gsub("`.", "")
        local payload = logonconsolemessage(modifiedMessage, thumbnailURL)
        SendWebhook(webhookURL, payload)
    end
end

AddCallback("Seelogs", "OnVarlist", function(varlist)
    local keywords = {
        { "Modchat", "https://cdn.discordapp.com/attachments/1053705409329889300/1222858334756016180/image_1.png?ex=6617be92&is=66054992&hm=639e7d0ceb1d81d327c08b3cc55f438778a7db513d82af5476333b6cdfcce194&" },
        { "used Ban", "https://cdn.discordapp.com/attachments/1053705409329889300/1222857217343225967/32.png?ex=6617bd88&is=66054888&hm=ed32af647bfcbaf9fb18571ff8f155cb468dcc922bed8ff24ff6121dc02e8ac0&" },
        { "used Duct Tape", "https://cdn.discordapp.com/attachments/1053705409329889300/1222857382334435408/32.png?ex=6617bdaf&is=660548af&hm=4755cdfabe2c6efc0aa810827681bcda78bfb4f66f8015ab877059e85dc3d7d9&" },
        { "used Curse", "https://cdn.discordapp.com/attachments/1053705409329889300/1222857267515232377/32.png?ex=6617bd94&is=66054894&hm=66aa5fdfb9d0fed34ceedd2f86df73624cb5bafff4d1abf15fa146050e5e9b95&" },
        { "used Sanctioned", "https://cdn.discordapp.com/attachments/1053705409329889300/1222859646973251594/1176908973375508581.png?ex=6617bfcb&is=66054acb&hm=5fb9161c94014d9e3bedc4cbd74ebb70d139763d6260eb32a5360b6eb4c73764&" },
        { "used Infected", "https://cdn.discordapp.com/attachments/1053705409329889300/1222856616895053925/32.png?ex=6617bcf9&is=660547f9&hm=665384f46efad89a18a29852589f5636784e7c085220d1bc4453e3e445e8c16b&" },
        { "used /renameworld", "https://cdn.discordapp.com/attachments/1053705409329889300/1222859812275093515/1176912325039640596.png?ex=6617bff2&is=66054af2&hm=4e88e120b7c3422c8e4e40aae49e3777d21af2050f7d418a662eb0d15d8644db&" },
        { "used Frozen", "https://cdn.discordapp.com/attachments/1053705409329889300/1222857250264059914/32.png?ex=6617bd90&is=66054890&hm=040090426d9c268d9c96eeb2fc57a8a83d2efc53ac93ef08797b3747b024ba22&" },
        { "has been nuked from orbit", "https://cdn.discordapp.com/attachments/1053705409329889300/1222858408093552740/1176911452926398545.png?ex=6617bea4&is=660549a4&hm=1c87d144a6fe06e2c37544beb8ad604d361fc66d3bfe9ba18b7ec9e4c4b6f8b8&" },
        { "smashed a non%-owned Lock", "https://cdn.discordapp.com/attachments/1053705409329889300/1222857321789521930/32.png?ex=6617bda1&is=660548a1&hm=0aa07807fb8c7f5d17873fe9d91a79c202f85dfb3179148e536892b1914076c1&" },
        { "modified inventory", "https://cdn.discordapp.com/attachments/1053705409329889300/1222860062197022781/32.png?ex=6617c02e&is=66054b2e&hm=30001282ddc70b65a453864b2df69e1d5abe308013b5e2226d7a8fa51bf21a3a&" },
        { "used /rename on", "https://cdn.discordapp.com/attachments/1053705409329889300/1222859812275093515/1176912325039640596.png?ex=6617bff2&is=66054af2&hm=4e88e120b7c3422c8e4e40aae49e3777d21af2050f7d418a662eb0d15d8644db&" },
        { "used /spk on", "https://cdn.discordapp.com/attachments/1053705409329889300/1222927481724735720/32.png?ex=6617fef8&is=660589f8&hm=47e6c2a101eb3dff067a832ac5c9ce398ab2f91d31cc14c4d88cb114e1945626&" },
		{ "MOD%-REPORT", "https://cdn.discordapp.com/attachments/1053705409329889300/1222931633829580921/32.png?ex=661802d6&is=66058dd6&hm=b35c6e5b3489c45cbf3b791b759642d77ce90a36dd9b0974e52761c37a0f6f93&" }
  }

    for _, pair in ipairs(keywords) do
        handler(varlist, pair[1], pair[2])
    end
end)

