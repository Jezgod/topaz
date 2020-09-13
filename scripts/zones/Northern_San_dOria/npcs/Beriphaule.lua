-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Beriphaule
-- Type: Allegiance Changer NPC
-- !pos -247.422 7.000 28.992 231
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
