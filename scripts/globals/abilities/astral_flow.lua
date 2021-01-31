-----------------------------------
-- Ability: Accession
-- Allows avatars to use their full strength and allows summmoning of Odin and Alexander.
-- Obtained: Summoner Level 1
-- Recast Time: 1:00:00
-- Duration: 0:03:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/keyitems")
-----------------------------------

function onAbilityCheck(player, target, ability)
    local pet = player:getPet()

    if not pet then
        return tpz.msg.basic.REQUIRES_A_PET, 0
    elseif pet:getLocalVar("[cd]astralflow") == 1 then
	return tpz.msg.basic.NO_EFFECT_ON_PET, 0
    else
        return 0, 0
    end
end

function onUseAbility(player, target, ability)
    local mJob = player:getMainJob()
    local ng_job = 0
    local id = tpz.effect.ATMA
    local atma = 91
    local pet = player:getPet()
    local mod1 = player:getCharVar("[atma]mod1")
    local val1 = player:getCharVar("[atma]val1")
    local mod2 = player:getCharVar("[atma]mod2")
    local val2 = player:getCharVar("[atma]val2")
    local mod3 = player:getCharVar("[atma]mod3")
    local val3 = player:getCharVar("[atma]val3")
    local hasKI = player:hasKeyItem(tpz.ki.ATMA_OF_THE_HATEFUL_STREAM)
    local pvpflag = player:getCharVar("pvp_flag")
    local cooldown = player:getLocalVar("[atma]cooldown")

    player:addStatusEffect(tpz.effect.ASTRAL_FLOW, 1, 0, 180)
    pet:setLocalVar("[cd]astralflow", 1)
 
    if (player:getCharVar("ng_job") ~= nil) then
        ng_job = player:getCharVar("ng_job")
    end

    if (hasKI and (val1 > 0 or val2 > 0 or val3 > 0) and 
        pvpflag == 1 and
        mJob == ng_job and
        cooldown < os.time()) then
 
	-- Pet modifiers
	pet:addMod(mod2 ,val2)
        pet:addMod(mod3 ,val3)

	-- Pet att/def adds to master mp
	--local mp = pet:getMaxHP() / 100
        local att = pet:getStat(tpz.mod.ATT) / 10
        local def = pet:getStat(tpz.mod.DEF) / 10
        local agg = att + def
        --printf("%u", agg)
	local m_val1 = agg * (1 + val1 / 10)
        --printf("%u", m_val1)

        player:setLocalVar("[atma]mod1",mod1)
        player:setLocalVar("[atma]val1",m_val1)
        player:setLocalVar("[atma]cooldown", os.time() + 1800)

        if (val2 > 0 or val3 > 0) then
	    player:PrintToPlayer( string.format("Atma applied to pet!"), 29 )
	end

        player:addStatusEffect(id, atma, 3, 1800)
    end

    return tpz.effect.ASTRAL_FLOW
end
