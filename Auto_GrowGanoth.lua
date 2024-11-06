-- Change these (You can only have one enabled)
local buyPog = true
local buyHorsie = false

-- Do not change
local World = "GROWGANOTH"
local Cooldown = false
local GotAmount = true

local function cLog(text)
	local var = {}
	var[0] = "OnConsoleMessage"
	var[1] = "`c[`bDuxii`c] "..text
	var.netid = -1
	SendVarlist(var)
end

function hook(varlist, packet)
	if varlist[0]:find("OnDialogRequest") then
        if varlist[1]:find("Dropped 250") then
		    return true
        end
	end
end

RunThread(function()
    while true do
        if GetLocal().world ~= World then
            SendPacket(2, "action|input\n|text|/warp " .. World)
            Sleep(1500)
            SendPacket(2, "action|input\n|text|`0Auto `bGrowganoth `0By `cDuxii `c(`bduxii#0001`c)")
            Sleep(950)
        else
            if buyHorsie == true then
                if GetItemCount(592) < 50 then
                    SendPacket(2, "action|input\n|text|`c[`b Duxii `c] `9Attempting to buy more Tiny Horsies.")
                    if GetLocal().gems < 15000 then
                        SendPacket(2,"action|input\n|text|`c[`b Duxii `c] `9Out of Gems to Purchase More Horsies.")
                        break
                    end
                    for i = 1, 15 do
                        SendPacket(2, "action|buy\nitem|buy_tinyhorse")
                        Sleep(150)
                    end
                    SendPacket(2, "action|input\n|text|`c[`b Duxii `c] `9Bought 50 Tiny Horsies!")
                    GotAmount = true
                end
            elseif buyPog == true then
                if GetLocal().gems < 15000 then
                    SendPacket(2,"action|input\n|text|`c[`b Duxii `c] `9Out of Gems to Purchase Pot O' Gems.")
                    break
                end
                if GetItemCount(15158) == 0 then
                    FindPath(39,53)
                    Sleep(150)
                    SendPacket(2,"action|dialog_return\ndialog_name|item_search\n-274|1")
                    Sleep(950)
                    SendPacket(2, "action|input\n|text|`c[`b Duxii `c] `9Bought 250 Pot O' Gems!")
                    GotAmount = true
                end
            end

            if GotAmount then
                if not Cooldown then
                    Sleep(950)
                    SendPacket(2, "action|input\n|text|`c[`b Duxii `c] `9Cooldown finished, finding `cPATH `9to `bGROWGANOTH!")
                    Sleep(150)
                    FindPath(49, 15)
                    Sleep(150)
                    if buyHorsie then
                        SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|592|\nitem_count|1")
                    elseif buyPog then
                        SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|-274|\nitem_count|1")
                    end
                    Cooldown = true
                end

                if Cooldown then
                    Sleep(950)
                    SendPacket(2, "action|input\n|text|`c[`b Duxii `c] `9Waiting `c30`9 Seconds until `cCooldown `2finished.")
                    Sleep(30000)
                    Cooldown = false
                end
                Sleep(250)
            end
        end
        Sleep(5000)
    end
end)

AddCallback("Block /find Dialog", "OnVarlist", hook)