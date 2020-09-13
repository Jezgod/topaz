-----------------------------------
-- Area: Western Adoulin
--  NPC: Fleuricette
-- Type: Ionis NPC
-- !pos 
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
require("scripts/globals/status")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local bayld = player:getCurrency("bayld")
    local cost = 100

    if (not player:hasStatusEffect(tpz.effect.IONIS)) then
        if (player:hasKeyItem(tpz.ki.PIONEERS_BADGE) and bayld >= cost) then 
            player:addStatusEffect(tpz.effect.IONIS, 0, 0, 14400)
            player:delCurrency("bayld", cost)
        else
	    player:PrintToPlayer("You cannot obtain the the Ionis effect.", 29)
        end
    else
        player:PrintToPlayer("You already posses the Ionis effect.", 29)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end