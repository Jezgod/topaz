-----------------------------------
-- Area: Metalworks
--  NPC: Mythily
-- Type: Immigration NPC
-- !pos 94 -20 -8 237
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:PrintToPlayer("Changing nations disabled.", 14)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
