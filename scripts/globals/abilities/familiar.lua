-----------------------------------
-- Ability: Familiar
-- Enhances your pet's powers and increases the duration of Charm.
-- Obtained: Beastmaster Level 1
-- Recast Time: 1:00:00
-- Duration: 0:30:00
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
    elseif not player:isJugPet() and pet:getObjType() ~= tpz.objType.MOB then
        return tpz.msg.basic.NO_EFFECT_ON_PET, 0
    elseif pet:getLocalVar("[cd]familiar") == 1 then
	return tpz.msg.basic.NO_EFFECT_ON_PET,0
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

    player:familiar()
    pet:setLocalVar("[cd]familiar", 1)
    
    -- pets powers increase!
    ability:setMsg(tpz.msg.basic.FAMILIAR_PC)
 
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

	-- Pet attack adds to master attack
	local att = pet:getStat(tpz.mod.ATT) / 100
	local m_val1 = att * (1 + val1 / 10)

        player:setLocalVar("[atma]mod1",mod1)
        player:setLocalVar("[atma]val1",m_val1)
        player:setLocalVar("[atma]cooldown", os.time() + 1800)

        if (val2 > 0 or val3 > 0) then
	    player:PrintToPlayer( string.format("Atma applied to pet!"), 29 )
	end

        player:addStatusEffect(id, atma, 3, 1800)
    end
end
