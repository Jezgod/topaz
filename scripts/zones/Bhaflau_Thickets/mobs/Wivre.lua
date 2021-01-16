-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Wivre
-----------------------------------

function onMobSpawn(mob)
end

function onMobEngaged(mob, target)
end

function onMobFight(mob, target)
    local rand = math.random(1000, 3000)

    if mob:getTP() > rand then
        mob:useMobAbility(2099) -- battlehorn
    end
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller)
end
