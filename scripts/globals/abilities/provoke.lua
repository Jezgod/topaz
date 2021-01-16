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
    local master = target:getMaster()
    local pet
   
    if (target:getObjType() == 1) then	
	user:setCursorTarget()
        target:addStatusEffect(tpz.effect.BIND,1,0,bindduration)
        target:addStatusEffect(tpz.effect.STUN,1,0,stunduration)
        target:addTP(TPGain)

	if (target:hasPet() == false) then
	    return 0
	else
            pet = target:getPet()
	    pet:wait(10000)
        end
    elseif (target:isPet()) then
 	if (master:getObjType() == 1) then
            pet = master:getPet()

            user:setCursorTarget()
            pet:addStatusEffect(tpz.effect.BIND,1,0,bindduration)
            pet:addStatusEffect(tpz.effect.STUN,1,0,stunduration)
            pet:addTP(TPGain)
            pet:wait(10000)
        else
 	    return 0
        end
    else
	return 0
    end
end