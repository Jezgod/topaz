-----------------------------------
-- Area: Valkurm Dunes
--  NPC: ??? (Spawn Valkurm Emperor)
-- !pos 488 -1 166 54
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    --if npcUtil.tradeHas(trade, 1126) then
    if (trade:hasItemQty(1126, 1) == true and trade:hasItemQty(846, 1) == true and trade:getGil() == 0 and trade:getItemCount() == 2) then 
        player:confirmTrade()
        --SpawnMob(ID.mob.VALKURM_EMPEROR):updateEnmity(player)
        SpawnMob(17199438):updateEnmity(player)
        --player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end
