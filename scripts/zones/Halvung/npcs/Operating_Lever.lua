-----------------------------------
-- Area: Halvung
-- Operating Lever Workaround
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

local coord =
{
    [17031670]		=	{x =   -117.819,   y =  18.349,   z =   -183.096,   rot = 0},
    [17031671]		=	{x =   -122.163,   y =  18.349,   z =   -183.100,   rot = 0},
    [17031674]		=	{x =   -237.813,   y =  18.347,   z =   -143.092,   rot = 0},
    [17031675]		=	{x =   -242.183,   y =  18.347,   z =   -143.092,   rot = 0},
    [17031678]		=	{x =   -237.804,   y =  18.339,   z =    -16.900,   rot = 0},
    [17031679]		=	{x =   -242.166,   y =  18.339,   z =    -16.900,   rot = 0},
    [17031682]		=	{x =   -117.805,   y = -11.658,   z =    223.100,   rot = 0},
    [17031683]		=	{x =   -122.175,   y = -11.658,   z =    223.100,   rot = 0},
    [17031686]		=	{x =   -376.898,   y =  -1.655,   z =    242.185,   rot = 0},
    [17031687]		=	{x =   -376.898,   y =  -1.655,   z =    237.835,   rot = 0},
}


function onTrade(player, npc, trade)
    local item = 2223 						-- Halvung Brass Key
    local hasKI = player:hasKeyItem(tpz.ki.BRACELET_OF_VERVE)

    if (not hasKI) then
        if npcUtil.tradeHasExactly(trade, item) then
            player:confirmTrade()
            player:addKeyItem(tpz.ki.BRACELET_OF_VERVE)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BRACELET_OF_VERVE)
	else
	    player:messageSpecial(ID.text.NOTHING_HAPPENS)
  	end
    else
	player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end 
end

function onTrigger(player, npc)
    local lever = npc:getID()
    --player:PrintToPlayer( string.format("Lever ID: %u", lever), 29)
    leverup = lever + 1
    local lever_map_up = coord[leverup]
    leverdown = lever - 1
    local lever_map_down = coord[leverdown]
    local hasKI = player:hasKeyItem(tpz.ki.BRACELET_OF_VERVE)

    if (hasKI) then
        if (lever_map_up == nil) then
	    if (lever_map_down == nil) then
		player:messageSpecial(ID.text.NOTHING_HAPPENS)
            else
	        player:setPos(lever_map_down.x, lever_map_down.y, lever_map_down.z, lever_map_down.rot)
	    end
        else
            player:setPos(lever_map_up.x, lever_map_up.y, lever_map_up.z, lever_map_up.rot)
        end
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
