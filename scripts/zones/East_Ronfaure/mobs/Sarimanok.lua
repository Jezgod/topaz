---------------------------------------------------------
-- Abyssite: Crimson Stratum I
-- Location: East Ronfaure
-- Voidwatch NM: Sarimanok
---------------------------------------------------------
local ID = require("scripts/zones/East_Ronfaure/IDs")
require("scripts/globals/keyitems")
mixins = {require("scripts/mixins/rage")}
---------------------------------------------------------

function onMobInitialize(mob)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

--[[
function onMobEngaged(mob, player)
    local count = player:getPartySize()
    local mobLvl = mob:getMainLvl()

    if count < 2 then
	mob:setMobLevel(mobLvl - 20)
        player:PrintToPlayer(string.format("%u", count), 29)
    elseif count < 3 then
	mob:setMobLevel(mobLvl - 10)
        player:PrintToPlayer(string.format("%u", count), 29)
    elseif count < 4 then
	mob:setMobLevel(mobLvl - 5)
        player:PrintToPlayer(string.format("%u", count), 29)
    else
    end
end
--]]

function onMobDisengage(mob)
    DespawnMob(ID.mob.SARIMANOK)
end

function onMobDeath(mob, player, isKiller)
    local void = ID.mob.SARIMANOK
    local hasAbyssite = player:hasKeyItem(tpz.ki.CRIMSON_STRATUM_ABYSSITE)
    local hasVoidstone = player:hasKeyItem(tpz.ki.VOIDSTONE1)
    local voidstone = tpz.ki.VOIDSTONE1
    
    if (hasAbyssite) then
        player:setCharVar("[void]" .. void, 1)
	player:PrintToPlayer(string.format("Victory over the Voidwatch NM has been captured by the Abyssite."), 29)
	player:delKeyItem(voidstone)
        player:messageSpecial(ID.text.KEYITEM_LOST,voidstone)
    end
end