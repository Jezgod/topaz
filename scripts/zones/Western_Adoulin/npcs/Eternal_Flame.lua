-----------------------------------
-- Area: Western Adoulin
-- NPC: Eternal Flame
-- Sparks NPC
-- !pos 
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
require("scripts/globals/shop")

--local crystal = {4096, 4099, 4101, 4098, 4097, 4100, 4102, 4103}
local ore = {1255, 1258, 1260, 1257, 1256, 1259, 1261, 1262}

local stock =
{
    	--1255, 1000000, -- Fire Ore
	--1256, 1000000, -- Ice Ore
        --1257, 1000000, -- Wind Ore
	--1258, 1000000, -- Earth Ore
	--1259, 1000000, -- Lightning Ore
	--1260, 1000000, -- Water Ore
	--1261, 1000000, -- Light Ore
	--1262, 1000000, -- Dark Ore
}

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    local badge = player:hasKeyItem(tpz.ki.PIONEERS_BADGE)

    if badge then
        player:PrintToPlayer(string.format("You may purchase the current day's available ore."), 29)
   	local daily_ore = 0
	daily_ore = ore[VanadielDayElement() + 1]
        table.insert(stock, daily_ore)    -- Ore of the Day
        table.insert(stock, 1000000)      -- Cost of ore
        tpz.shop.general(player, stock)
    else
	player:PrintToPlayer(string.format("Pioneer's Badge required to view stock."), 29)
    end
end