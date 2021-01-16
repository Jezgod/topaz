-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  Mob: Ob
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
-----------------------------------
-- Todo: Pups can make it change frames, Overload causes Rage

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:addMod(tpz.mod.MDEF, 150)
    mob:addMod(tpz.mod.DEF, 150)
    mob:addMod(tpz.mod.ATT, 300)
    mob:addMod(tpz.mod.CRITHITRATE, 100)
    mob:addMod(tpz.mod.REGEN, math.floor(mob:getMaxHP()*.008))
end

function onMobDeath(mob)
    mob:setRespawnTime(math.random(300, 600)) -- 5 to 10 minutes
end
