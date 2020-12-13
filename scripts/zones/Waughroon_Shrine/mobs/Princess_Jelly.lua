-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Princess Jelly
-- BCNM: Royal Jelly
-----------------------------------

function onMobEngaged(mob, target)
    mob:setLocalVar("docile", os.time() + 30)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
end

function onMobFight(mob, target)
 if os.time() > mob:getLocalVar("docile") then
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    end
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller)
end
