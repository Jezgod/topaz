-----------------------------------
-- Ability: Animated Flourish
-- Provokes the target. Requires at least one, but uses two Finishing Moves.
-- Obtained: Dancer Level 20
-- Finishing Moves Used: 1-2
-- Recast Time: 00:30
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)

    if (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_1)) then
        return 0, 0

    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_2)) then
        return 0, 0

    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_3)) then
        return 0, 0

    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_4)) then
        return 0, 0

    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_5)) then
        return 0, 0
    else
        return tpz.msg.basic.NO_FINISHINGMOVES, 0
    end
end

function onUseAbility(player, target, ability)
    local bindduration = 2
    local stunduration = 1
    local duration = 1
    local TPGain = 1000
    local pet = target:getPet()

    if (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_1)) then
        player:delStatusEffect(tpz.effect.FINISHING_MOVE_1)

    --Add extra enmity if 2 finishing moves are used
    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_2)) then
        player:delStatusEffect(tpz.effect.FINISHING_MOVE_2)
	if (target:getObjType() == 1 or target:getObjType() == 8) then	
		player:setCursorTarget();
                target:addStatusEffect(dsp.effect.BIND,1,0,bindduration);
                target:addStatusEffect(dsp.effect.STUN,1,0,stunduration);
                target:addTP(TPGain);
	else
		target:addEnmity(player, 0, 500)
	end
        
    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_3)) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_3)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_1, 1, 0, 7200)
        if (target:getObjType() == 1 or target:getObjType() == 8) then	
		player:setCursorTarget();
                target:addStatusEffect(dsp.effect.BIND,1,0,bindduration);
                target:addStatusEffect(dsp.effect.STUN,1,0,stunduration);
                target:addTP(TPGain);
	else
		target:addEnmity(player, 0, 500)
	end

    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_4)) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_4)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_2, 1, 0, 7200)
        if (target:getObjType() == 1 or target:getObjType() == 8) then	
		player:setCursorTarget();
                target:addStatusEffect(dsp.effect.BIND,1,0,bindduration);
                target:addStatusEffect(dsp.effect.STUN,1,0,stunduration);
                target:addTP(TPGain);
	else
		target:addEnmity(player, 0, 500)
	end

    elseif (player:hasStatusEffect(tpz.effect.FINISHING_MOVE_5)) then
        player:delStatusEffectSilent(tpz.effect.FINISHING_MOVE_5)
        player:addStatusEffect(tpz.effect.FINISHING_MOVE_3, 1, 0, 7200)
        if (target:getObjType() == 1 or target:getObjType() == 8) then	
		player:setCursorTarget();
                target:addStatusEffect(dsp.effect.BIND,1,0,bindduration);
                target:addStatusEffect(dsp.effect.STUN,1,0,stunduration);
                target:addTP(TPGain);
	else
		target:addEnmity(player, 0, 500)
	end
    end
end
