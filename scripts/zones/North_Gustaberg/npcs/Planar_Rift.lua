-----------------------------------
-- Area: North Gustaberg
--  NPC: ??? 
-- !pos 
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local abyssite = player:hasKeyItem(tpz.ki.CRIMSON_STRATUM_ABYSSITE)
    local voidstone = player:hasKeyItem(tpz.ki.VOIDSTONE1)

   if not GetMobByID(ID.mob.SALLOW_SEYMOUR):isSpawned() then
        if (abyssite and voidstone) then
  	    SpawnMob(ID.mob.SALLOW_SEYMOUR):updateClaim(player)
        else
	    player:messageSpecial(ID.text.NOTHING_HAPPENS)
        end
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end
