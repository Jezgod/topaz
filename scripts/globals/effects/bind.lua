-----------------------------------
--
-- tpz.effect.BIND
--
-----------------------------------

function onEffectGain(target, effect)
    if (target:getObjType() == 1) then
        effect:setPower(50)
    else
        effect:setPower(target:speed())
    end
    target:speed(0)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:speed(effect:getPower())
end
