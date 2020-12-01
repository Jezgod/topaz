-----------------------------------
-- Ability: Provoke
-- Goads an enemy into attacking you.
-- Obtained: Warrior Level 5
-- Recast Time: 0:30
-- Duration: 30 seconds
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
-----------------------------------

function onAbilityCheck(player,target,ability)
    return 0,0
end

function onUseAbility(user,target,ability)
    local bindduration = 2
    local stunduration = 1
    local TPGain = 1000
    local pet = target:getPet()

    if (target:getObjType() == 1 or target:getObjType() == 8) then	
	user:setCursorTarget()
        target:addStatusEffect(tpz.effect.BIND,1,0,bindduration)
        target:addStatusEffect(tpz.effect.STUN,1,0,stunduration)
        target:addTP(TPGain)

	if (target:hasPet() == false) then
	    return 0
	else
	    pet:wait(10000)
        end
    else
    end
end