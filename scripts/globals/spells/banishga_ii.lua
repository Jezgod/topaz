-----------------------------------------
-- Spell: Banishga 2/WHM Banishga 3
-- Deals light damage to an enemy.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    --doDivineBanishNuke(V, M, caster, spell, target, hasMultipleTargetReduction, resistBonus)
    local params = {}
    params.dmg = 180
    params.multiplier = 1
    params.hasMultipleTargetReduction = false
    params.resistBonus = 1.0

    if (caster:getMainJob() == tpz.job.WHM and caster:hasStatusEffect(tpz.effect.DIVINE_SEAL)) then
        params.dmg = 480
	caster:PrintToPlayer( string.format( "Spell enhanced by Divine Seal." ), 29);
    end

    dmg = doDivineBanishNuke(caster, target, spell, params)
    return dmg
end
