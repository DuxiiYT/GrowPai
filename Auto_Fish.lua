local CaughtFish = false -- don't touch
local waterX = 0 -- Water X
local waterY = 0 -- Water Y
local fishingBait = 3016 -- Fishing fly

local function Place(x, y, id)
  local player = GetLocal()
  local punchPacket = {
    type = 3,
    int_data = id,
    pos_x = player.pos_x,
    pos_y = player.pos_y,
    int_x = x,
    int_y = y,
  }
  SendPacketRaw(punchPacket)
end

local function Overlay(text)
        local packet = {
                [0] = "OnTextOverlay",
                [1] = text,
                netid = -1
        }
        SendVarlist(packet)
end

function IncomingHook(packet)
    if packet.type == 17 then
        Place(waterX, waterY, fishingBait)
    end
end

AddCallback("Hook", "OnIncomingRawPacket", IncomingHook)

AddCallback("Caught Fish", "OnVarlist", function(varlist)
    if varlist[0] == "OnConsoleMessage" then
        if varlist[1]:find("You caught") or varlist[1]:find("There was") then
            CaughtFish = true
        end
    end
end)

SendPacket(2,"action|input\n|text|`9Made by `bDuxii!")

while true do
    if CaughtFish then
        Sleep(950)
        Place(waterX, waterY, fishingBait)
        Sleep(150)
        Overlay("`c[`bDuxii`c] `9Caught Fish")
        Sleep(250)
        CaughtFish = false
    end
end