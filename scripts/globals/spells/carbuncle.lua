-----------------------------------------
-- Spell: Carbuncle
-- Summons Carbuncle to fight by your side
-----------------------------------------
require("scripts/globals/summon")
require("scripts/globals/pets")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    local weapon = caster:getEquipID(0)
    local mjob = caster:getMainJob()

    if (not caster:canUseMisc(tpz.zoneMisc.PET)) then
        return tpz.msg.basic.CANT_BE_USED_IN_AREA
    elseif (caster:hasPet()) then
        return tpz.msg.basic.ALREADY_HAS_A_PET
    elseif (mjob ~= tpz.job.SMN) then
        return tpz.msg.basic.CANNOT_PERFORM
    elseif (weapon == 0) then
	return tpz.msg.basic.CANNOT_PERFORM
    else
        return 0
    end
end

function onSpellCast(caster, target, spell)
    tpz.pet.spawnPet(caster, tpz.pet.id.CARBUNCLE)
    return 0
end
