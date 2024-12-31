# Functions
* [SendPacket](#sendpacket)
* [SendPacketRaw](#sendpacketraw)
* [SendPacketRawClient](#sendpacketrawclient)
* [SendVarlist](#sendvarlist)
* [log](#log)
* [FindPath](#findpath)
* [GetLocal](#getlocal)
* [GetInventory](#getinventory)
* [GetPlayers](#getplayers)
* [GetObjects](#getobjects)
* [GetTile](#gettile)
* [GetTiles](#gettiles)
* [GetPing](#getping)
* [AddCallback](#addcallback)
* [RunThread](#runthread)
* [Sleep](#sleep)
* [GetAccesslist](#getaccesslist)
* [GetGhost](#getghost)
* [MessageBox](#messagebox)
* [RemoveCallbacks](#removecallbacks)
* [RemoveCallback](#removecallback)
* [Timer](#timer)
* [IsSolid](#issolid)
* [SendWebhook](#sendwebhook)
* [CheckPath](#checkpath)
* [EditToggle](#edittoggle)
* [GetItemCount](#getitemcount)
* [GetIteminfo](#GetIteminfo)
* [PathFind](#PathFind)


## SendPacket
`SendPacket(int type, string packet)`

Sends text packet with selected type to server.

Example:
```lua
-- Sends respawn packet to server
SendPacket(2, "action|input\n|text|hello")
```

## SendPacketRaw
`SendPacketRaw(GamePacket packet)`

Sends [GamePacket](#gamepacket) to server.

Example:
```lua
-- Sends wear clothing packet to server
local packet = {}
packet.type = 10 
packet.int_data = 48 -- Clothing ID (Jeans)
SendPacketRaw(packet)
```

## SendPacketRawClient
`SendPacketRawClient(GamePacket packet)`

Sends [GamePacket](#gamepacket) to client.

Example:
```lua
-- Sends packet_state flag to client
local packet = {}
packet.type = 0 
packet.flags = 48 -- flags
SendPacketRaw(packet)
```

## SendVarlist
`SendVarlist(table varlist)`

Example:
```lua
local var = {} --make table
var[0] = "OnConsoleMessage"
var[1] = "Dababy!"
var.netid = -1 --need to put netid or it doesn't work

SendVarlist(var)
```

## log
`log(string message)`

Logs message to Growtopias console (only client side)

Example:
```lua
-- Logs "Hello!" to Growtopias console
log("Hello!")
```

## FindPath
`FindPath(int x, int y)`

Finds path to selected x,y

Example:
```lua
-- Finds path to top left corner of the world
FindPath(0, 0)
```

## GetLocal
`GetLocal()`

Returns local [NetAvatar](##netavatar) struct

Example:
```lua
-- Logs local players name
local me = GetLocal()
log(me.name)

--changing name
local Player = GetLocal()
Player.name = "`wkontol``"
```

## GetInventory
`GetInventory()`

Returns table of [InventoryItems](#inventoryitem)

Example:
```lua
-- Logs all item ids in your inventory
for _,cur in pairs(GetInventory()) do
	log(cur.id)
end
```

## GetPlayers
`GetPlayers()`

Returns table of [NetAvatars](#netavatar)

Example:
```lua
-- Logs current worlds players names
for _,player in pairs(GetPlayers()) do
	log(player.name)
end
```

## getObjects
`GetObjects()`

Returns table of [WorldObjects](#worldobject)

Example:
```lua
-- Logs current worlds floating item id's
for _,object in pairs(GetObjects()) do
	log(object.id)
end
```

## GetTile
`GetTile(int x, int y)`

Returns world [Tile](#tile) in selected position

Example:
```lua
-- Logs top left corners foreground block id
local tile = GetTile(0, 0)
log(tile.fg)
```

## GetTiles
`GetTiles()`

Returns table of [Tiles](S#tile)

Example:
```lua
-- Logs current worlds all foreground block id's
for _,tile in pairs(GetTiles()) do
	log(tile.fg)
end
```

## RunThread
`RunThread(function)`
Run a function in a different thread

Example
```lua
RunThread(function()
	log("Hello")
	Sleep(1000)
	log("World!")
end)
```

## Sleep
`Sleep(int ms)`
put a delay inside a [Thread](#runthread)

Example:
```lua
local function wow(a, b)
	log(a)
	Sleep(1000)
	log(b)
end
RunThread(function()
	wow("Hello", "World")
end)
```

## AddCallback
`AddCallback(string name, void* function)`
Add a callback Hook to a selected function

Example:
```lua
-- Blocks all dialogs
function hook(varlist, packet)
	if varlist[0]:find("OnDialogRequest") then
		return true
	end
end

AddCallback("Hook", "OnVarlist", hook)

-- Blocks your chat
function hook(type, packet)
	if packet:find("action|input\n|text") then
		return true
	end
end

AddCallback("Hook", "OnPacket", hook)

-- Blocks your packet_state
function hook(packet)
	if packet.type == 0 then
		return true
	end
end

AddCallback("Hook", "OnRawPacket", hook)

-- Blocks people packet_state
function hook(packet)
	if packet.type == 0 then
		return true
	end
end

AddCallback("Hook", "OnIncomingRawPacket", hook)

--Update timer
AddCallback("timer", "OnUpdate", function(deltatime)
	timer.Update(deltatime)
end)

--On Touch
AddCallback("touch", "OnTouch", function(pos)
	print(pos.x)
	print(pos.y)
end)
```

## GetPing
`GetPing()`
Get ping ms from your peer

Example:
```lua
log("My ping is : "..tostring(GetPing()))
```

## GetAccesslist
`GetAccesslist(int x, int y)`
Get lock's access userid list

Example:
```lua
for __,v in pairs(GetAccesslist(0,0)) do
	log(v.uid)
end
```


## GetGhost
`GetGhost()`
Get all ghost npc id and pos

Example:
```lua
for __,v in pairs(GetGhost()) do
	log(string.format("%d : %d, %d",v.id, v.pos_x, v.pos_y))
end
```

## MessageBox
`MessageBox(string title, string content)`
Send a messagebox to your client!

Example:
```lua
MessageBox("This is title", "This is content")
```

## RemoveCallbacks
`RemoveCallbacks()`
Remove all callbacks

## RemoveCallback
`RemoveCallback(string name)`
Remove spesific name on callback

Example:
```lua
function hook(varlist, packet)
	if varlist[0]:find("OnDialogRequest") then
		return true
	end
end
AddCallback("Hook", "OnVarlist", hook)

RemoveCallback("Hook") --remove that callback
```

## Timer
Timer library by https://github.com/EntranceJew/timer
the docs: https://wiki.facepunch.com/gmod/timer

Example:
```lua
--Create a timer update callback
AddCallback("timer", "OnUpdate", function(deltatime)
	timer.Update(deltatime)
end)

timer.Create("timer name", 5, 0, function()
	print("me nem kontol")
	--this will print in 5 second
end)

timer.Destroy("timer name")-- destroy timer
```

## IsSolid
`IsSolid(int x, int y)`
Check if the block is solid or no

## SendWebhook
`SendWebhook(string webhook, string json)`

Example:
```lua
local payload = [[{
    "content": "",
    "embeds": [{
        "title": "Title",
        "description": "Description"
    }]
}]]
local webhook = ""
SendWebhook(webhook, payload)
```


## CheckPath
`CheckPath(int x, int y)`

Example:
```lua
	CheckPath(0, 0) -- return bool (true == found path)
```

## EditToggle
`EditToggle(string module, bool toggle)`

Example:
```lua
	EditToggle("antibounce", true)-- active antibounce
```
## Module list:
* MenuToggle
* Execute Luascript
* Stop Luascript
* Antiportal
* ModFly
* Autocollect
* Antibounce

## GetItemCount
`GetItemCount(int id)`

Example:
```lua
log(GetItemCount(2))--return dirt count in your inventory
```
## GetIteminfo
`GetIteminfo(int id)`

Returns table of [ItemInfo](#ItemInfo)

Example:
```lua
log(GetIteminfo(2).name)--return name of id block 2
```

## PathFind
`PathFind(int x, int y)`

Returns table of path to destination

Example:
```lua
local path = PathFind(46, 10)
print(#path) -- how much block does it take to that destination
for i, v in pairs(path) do
	print(("%d, %d"):format(v.x, v.y))
end
```


# Structs

* [NetAvatar](#netavatar)
* [WorldObject](#worldobject)
* [InventoryItem](#inventoryitem)
* [Tile](#tile)
* [GamePacket](#gamepacket)
* [VariantList](#variantlist)
* [ItemInfo](#iteminfo)

## NetAvatar
| Type | Name | Description|
|:-----|:----:|:-----------|
| String | `name` | Player's name |
| String | `world` | Player's world(only local) |
| String | `country` | Player's flag id |
| Number | `pos_x`  | Player's x position |
| Number | `pos_y`  | Player's y position |
| Number | `tile_x` | Player's x tile position |
| Number | `tile_y` | Player's y tile position |
| Number | `size_x` | Player's x size |
| Number | `size_y` | Player's x size |
| Number | `netid` | Player's netID |
| Number | `userid` | Player's userID |
| Number | `gems` | Player's gems |
| Bool | `facing_left` | Is player facing left |
| Number | `flags` | Player's flags |
| Number | `flags2` | Player's flags2 |

## WorldObject
| Type | Name | Description|
|:-----|:----:|:-----------|
| Number | `id` | Object's item ID |
| Number | `oid` | Object's index |
| Number | `pos_x` | Object's x position |
| Number | `pos_y` | Object's y position |
| Number | `count` | Object's item count |
| Number | `flags` | Object's flags |

## InventoryItem
| Type | Name | Description|
|:-----|:----:|:-----------|
| Number | `id` | Item's ID |
| Number | `count` | Item count |

## Tile
| Type | Name | Description|
|:-----|:----:|:-----------|
| Number | `fg` | Foreground block's ID |
| Number | `bg` | Background block's ID |
| Number | `pos_x` |Tile's x position |
| Number | `pos_y` |Tile's y position |
| Number | `flags` | Tile's flags |
| bool | `water` | Tile's water |
| bool | `fire` | Tile's fire |
| bool | `ready` | Tile's ready to harvest |

## GamePacket
| Type | Name | Description|
|:-----|:----:|:-----------|
| Number | `type` | Packet type |
| Number | ` objtype` |  |
| Number | `count1 ` |  |
| Number | `count2 ` |  |
| Number | `netid ` | Packet netID |
| Number | `item ` |  |
| Number | `flags ` | Packet flags |
| Number | `float1` |  |
| Number | `int_data` |  |
| Number | `pos_x` |  |
| Number | `pos_y` |  |
| Number | `pos2_x` |  |
| Number | `pos2_y` |  |
| Number | `float2` |  |
| Number | `int_x` |  |
| Number | `int_y` |  |

## VariantList
| Type | Name | Description|
|:-----|:----:|:-----------|
| Number | `netid` | NetID |
| Number | `delay` | Delay |
| String | `[0]` | Variant function name |
| Any | `[1]` | Param 1 |
| Any | `[2]` | Param 2 |
| Any | `[3]` | Param 3 |
| Any | `[4]` | Param 4 |
| Any | `[5]` | Param 5 |

## ItemInfo
| Type | Name | Description|
|:-----|:----:|:-----------|
| String | `name` | item's name |
| Number | `item_type` | Item's type |
| Number | `growth` | Item's growth |
| Number | `rarity` | Item's rarity |
| Number | `size` | Items list size |


## Client Packets
<img src="https://media.discordapp.net/attachments/1005951979400462347/1323606567051853865/image.png?ex=6775202d&amp;is=6773cead&amp;hm=438c04a0735068a98195886424c50ab8460537ff69c748be2775c91b1b4f5860&amp;=&amp;format=webp&amp;quality=lossless&amp;width=300&amp;height=421" alt="Image"/>![image](https://github.com/user-attachments/assets/58508835-60a9-44cc-8fe8-ed7ae270948a)
<img src="https://media.discordapp.net/attachments/1005951979400462347/1323606632634122302/image.png?ex=6775203c&amp;is=6773cebc&amp;hm=c08121363015ea57d0fcc38beb4aa3f8c5ea9a6eb8efc95d8b21cc2bdccdc15b&amp;=&amp;format=webp&amp;quality=lossless&amp;width=381&amp;height=421" alt="Image"/>![image](https://github.com/user-attachments/assets/abe80fe5-429c-42f5-88b5-97a0cac09b02)

## Dialog
<img src="https://media.discordapp.net/attachments/1005951979400462347/1323606784556007515/image.png?ex=67752060&amp;is=6773cee0&amp;hm=dca090d057e971558187c8e1b47661198e484245fb0826a50274ef4d407ecbf2&amp;=&amp;format=webp&amp;quality=lossless&amp;width=202&amp;height=421" alt="Image"/>![image](https://github.com/user-attachments/assets/2b68acc8-98b3-47a5-9151-d03b839665a7)
<img src="https://media.discordapp.net/attachments/1005951979400462347/1323606867590778980/image.png?ex=67752074&amp;is=6773cef4&amp;hm=966fd7bc89c7c51a0e9546b90f5b6791629e54951413c4f1bc03c99e52305c63&amp;=&amp;format=webp&amp;quality=lossless&amp;width=431&amp;height=421" alt="Image"/>![image](https://github.com/user-attachments/assets/ed758a8b-de26-4145-8bc7-01e7b86c0971)
<img src="https://media.discordapp.net/attachments/1005951979400462347/1323606897592373338/image.png?ex=6775207b&amp;is=6773cefb&amp;hm=81ef877a731afd382c07547f89bbd62fbaafba25704ac06fd2e2c44671834443&amp;=&amp;format=webp&amp;quality=lossless" alt="Image"/>![image](https://github.com/user-attachments/assets/8edd8c6a-67e6-4e52-9e46-9312c9eed8a3)
