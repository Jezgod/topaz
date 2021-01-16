-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Colibri
-----------------------------------
--mixins = {require("scripts/mixins/families/colibri_mimic")}
-----------------------------------

function onMobFight(mob, target)
    local delay = mob:getLocalVar("delay")
    local LastCast = mob:getLocalVar("LAST_CAST")
    local spell = mob:getLocalVar("COPY_SPELL")
    local changeTime = mob:getLocalVar("changeTime")

    if spell > 0 and mob:hasStatusEffect(tpz.effect.SILENCE) == false and target:AnimationSub() == 1 then
        if delay >= 2 then
            mob:castSpell(spell)
            mob:setLocalVar("COPY_SPELL", 0)
            mob:setLocalVar("delay", 0)
            target:AnimationSub(4)
        else
            mob:setLocalVar("delay", delay+1)
        end
    end
end

function onMagicHit(caster, target, spell)
    if spell:tookEffect() and target:AnimationSub() == 4 and (caster:isPC() or caster:isPet()) then
        target:setLocalVar("COPY_SPELL", spell:getID())
        target:setLocalVar("LAST_CAST", target:getBattleTime())
        target:AnimationSub(1)
    end

    return 0
end

function onMobDeath(mob, player, isKiller)
end
