-- Do not touch
AutoSurg = false

local function Overlay(text)
        local packet = {
                [0] = "OnTextOverlay",
                [1] = text,
                netid = -1
        }
        SendVarlist(packet)
end

function Sponge()
    SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_0")
    Overlay("`c[`9Duxii`c]`c Using Sponge")
end

function Anasthetic()
    SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_2")
    Overlay("`c[`9Duxii`c]`c Using Anasthetic")
end

function Scalpel()
    SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_1")
    Overlay("`c[`9Duxii`c]`c Using Scalpel")
end

function Antiseptic()
    SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_3")
    Overlay("`c[`9Duxii`c]`c Using Antiseptic")
end

function Antibiotics()
    SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_4")
    Overlay("`c[`9Duxii`c]`c Using Antibiotic")
end

function Stitches()
    SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_6")
    Overlay("`c[`9Duxii`c]`c Using Stitches")
end

function Fix()
    SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_7")
    Overlay("`c[`9Duxii`c]`c Fixing...")
end

function Modage()
    SendPacket(2, "action|input\n|text|/modage 60")
	Overlay("`c[`9Duxii`c]`c Used /modage")
end

function hook(type, packet)
    if packet:find("action|wrench\n|netid|(%d+)") then
        if not AutoSurg then
            AutoSurg = true
            local ID = packet:match("action|wrench\n|netid|(%d+)")
            SendPacket(2, "action|dialog_return\ndialog_name|popup\nnetID|".. ID .."\nbuttonClicked|surgery\n")
            AutoSurg = false
            return true
        end
    end
end

AddCallback("aaaa", "OnPacket", hook)

AddCallback("Surg", "OnVarlist", function(varlist)
    if varlist[0] == "OnDialogRequest" then
        if varlist[1]:find("Patient's fever is `3slowly rising") and varlist[1]:find("command_4") then
            Antibiotics()
            return true
        elseif varlist[1]:find("Patient's fever is `6climbing") and varlist[1]:find("command_4") then
            Antibiotics()
            return true
        elseif varlist[1]:find("Incisions: `60") and varlist[1]:find("command_7") then
            Fix()
            return true
        elseif varlist[1]:find("Incisions: `30") and varlist[1]:find("command_7") then
            Fix()
            return true
        elseif varlist[1]:find("command_7") then
            Fix()
            return true
        elseif varlist[1]:find("Operation site: `6Unclean") and varlist[1]:find("command_3") then
            Antiseptic()
            return true
        elseif varlist[1]:find("Operation site: `4Unsanitary") and varlist[1]:find("command_3") then
            Antiseptic()
            return true
        elseif varlist[1]:find("Status: `4Awake!") and varlist[1]:find("command_3") then
            Anasthetic()
            return true
        elseif varlist[1]:find("`4You can't see what you are doing(!+)") and varlist[1]:find("command_0") then
            Sponge()
            return true
        elseif varlist[1]:find("`6It is becoming hard to see your work(.+)") and varlist[1]:find("command_0") then
            Sponge()
            return true
        elseif varlist[1]:find("Patient is losing blood `4very quickly!") and varlist[1]:find("command_6") then
            Stitches()
            return true
        elseif varlist[1]:find("Patient is losing blood `3slowly") and varlist[1]:find("command_6") then
            Stitches()
            return true
        elseif varlist[1]:find("Patient is `6losing blood!") and varlist[1]:find("command_6") then
            Stitches()
            return true
        elseif varlist[1]:find("command_7") and varlist[1]:find("command_6") then
            Stitches()
            return true
        elseif varlist[1]:find("command_7") and varlist[1]:find("command_1") then
            Scalpel(false)
            return true
        elseif varlist[1]:find("command_1") then
            Scalpel()
            return true
        end
    end
end)

AddCallback("Mod-age", "OnVarlist", function(varlist)
    if varlist[0] == "OnConsoleMessage" then
		if varlist[1]:find("You are not allowed") then
			modage()
		end
    end
end)

SendPacket(2,"action|input\n|text|`9Made By `bDuxii!")