------------------------------
-- Area: Beaucedine Glacier [S]
--  Mob: Ruszor
------------------------------
require("scripts/globals/bluelearn")
require("scripts/globals/mobs")
require("scripts/globals/status")
------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 2)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE)
end

function onMobDeath(mob, player, isKiller)
    tpz.blu.checkBlueKill(mob, player, 654)
end
