local Text11 = {"Nothing here yet..."}
local AllLogs = {}

AddCallback("Copy Sign Text(PC)", "OnVarlist", function(varlist)
    if varlist[0] == "OnDialogRequest" then
        for _, actualtext in ipairs(varlist) do
            local signstart, signend = actualtext:find("display_text||")
            if signstart then
                local signtext = actualtext:find("|", signend  + 1)
                if signtext then
                    local newtext = actualtext:sub(signend + 1, signtext - 1)
                    if not table.contains(AllLogs, newtext) then
                        Text11 = {newtext}
                        table.insert(AllLogs, newtext)
                    end
                end
            end
        end
    end
end)

local function createmenu(text)
    local textPacket = {}
    textPacket[0] = "OnDialogRequest"
    textPacket[1] = text
    textPacket.netid = -1
    SendVarlist(textPacket)
end

local function textmenu(text12)
    local text = [[
add_label_with_icon|big|CreativePS Sign Copier|left|]] .. 278 .. [[|
add_spacer|smal|
add_textbox|`9- `b@Xylon|
add_spacer|smal|
add_textbox|`9Current text:|]] 

    for i, v in ipairs(Text11) do
        text = text .. "\nadd_textbox|" .. v .. "|"
    end

    text = text .. [[
add_spacer|big|
add_spacer|smal|
add_textbox|`9Recent Logs:|]]

    for i, v in ipairs(AllLogs) do
        text = text .. "\nadd_textbox|" .. v .. "|"
    end

    text = text .. [[
add_spacer|smal|
add_button||Close|
]]
    createmenu(text)
end

local function split(inputstr, sep)
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

local function CommandHook(type, packet)
    local args = split(packet:gsub("action|input\n|text|", ""), " ")
    local command = string.lower(args[1])
    local VALUE = args[2]
    if VALUE then
        SEARCH_USER = VALUE:gsub("/", "")
    end
    local current_args = {}
    for i=3, #args, 1 do
        table.insert(current_args, args[i])
    end

    if command == "/text" then
        textmenu(Text11)
    end
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

AddCallback("Command Handler", "OnPacket", CommandHook)

local function LOGG(text)
        local var = {}
        var[0] = "OnConsoleMessage"
        var[1] = "`b[`2Xylon`b]`6 Text is now in your clipboard! `4(CTRL + V)`6 to paste"
        var.netid = -1
        SendVarlist(var)
end

AddCallback("Copy Sign", "OnVarlist", function(varlist)
    if varlist[0] == "OnDialogRequest" then
        for _, actualtext in ipairs(varlist) do
            local signstart, signend = actualtext:find("display_text||")
            if signstart then
                local signtext = actualtext:find("|", signend  + 1)
                if signtext then
                    local textaa = actualtext:sub(signend + 1, signtext - 1)
                        local powershell = io.popen("powershell Set-Clipboard -Value '" .. textaa .. "'", "w")
                        powershell:close()
                        LOGG(textaa)
                end
            end
        end
    end
end)