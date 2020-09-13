-----------------------------------
-- Area: Heavens Tower
--  NPC: Rakano-Marukano
-- Type: Immigration NPC
-- !pos 6.174 -1 32.285 242
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
