-- Change these
local TargetAmount = 2
local CompletedAmount = 0

-- Do not change
local DoorPos = {26, 25}
local CarnivalEndPos = {24, 24}
local CarnivalStarted = false
local GameCompleted = false

local function UseDoor(x, y)
    SendPacketRaw({
        type = 7,
        int_x = x,
        int_y = y,
    })
end

local function Overlay(text)
    local packet = {
        [0] = "OnTextOverlay",
        [1] = text,
        netid = -1
    }
    SendVarlist(packet)
end

local function OnVarlistCallback(varlist)
    if GameCompleted then return end

    if varlist[0] == "OnTalkBubble" then
        local Message = varlist[2]
        if Message:find("You finished with") then
            CompletedAmount = CompletedAmount + 1
            
            if CompletedAmount >= TargetAmount then
                Overlay("`c[`b@Duxii`c] `9You have completed all " .. TargetAmount .. " games!")
                GameCompleted = true
                return
            else
                Overlay("`c[`b@Duxii`c] `9Completed " .. CompletedAmount .. " games out of " .. TargetAmount)
            end

            FindPath(DoorPos[1], DoorPos[2])
            Sleep(80)
            UseDoor(DoorPos[1], DoorPos[2])
        end
    elseif varlist[0] == "OnCountdownStart" then
        CarnivalStarted = true
    end
end

AddCallback("Auto Carnival", "OnVarlist", OnVarlistCallback)

RunThread(function()
    while true do
        if CarnivalStarted then
            Sleep(500)
            FindPath(CarnivalEndPos[1], CarnivalEndPos[2])
            CarnivalStarted = false
        end
        
        if GameCompleted then
            break
        end
    end
end)
