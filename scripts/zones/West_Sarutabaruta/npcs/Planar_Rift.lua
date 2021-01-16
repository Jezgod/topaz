-----------------------------------
-- Area: West Sarutabaruta
--  NPC: Planar Rift
-- !pos 
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local abyssite = player:hasKeyItem(tpz.ki.JADE_STRATUM_ABYSSITE)
    local voidstone = player:hasKeyItem(tpz.ki.VOIDSTONE1)

   if not GetMobByID(ID.mob.VIRVATULI):isSpawned() then
        if (abyssite and voidstone) then
  	    SpawnMob(ID.mob.VIRVATULI):updateClaim(player)
        else
	    player:messageSpecial(ID.text.NOTHING_HAPPENS)
        end
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end
