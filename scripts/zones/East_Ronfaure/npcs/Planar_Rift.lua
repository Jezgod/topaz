-----------------------------------
-- Area: East Ronfaure
--  NPC: Planar Rift
-- !pos 
-----------------------------------
local ID = require("scripts/zones/East_Ronfaure/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local abyssite = player:hasKeyItem(tpz.ki.INDIGO_STRATUM_ABYSSITE)
    local voidstone = player:hasKeyItem(tpz.ki.VOIDSTONE1)

   if not GetMobByID(ID.mob.SARIMANOK):isSpawned() then
        if (abyssite and voidstone) then
  	    SpawnMob(ID.mob.SARIMANOK):updateClaim(player)
        else
	    player:messageSpecial(ID.text.NOTHING_HAPPENS)
        end
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end
