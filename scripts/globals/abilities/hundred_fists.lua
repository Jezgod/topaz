-----------------------------------
-- Ability: Hundred Fists
-- Speeds up attacks.
-- Obtained: Monk Level 1
-- Recast Time: 1:00:00
-- Duration: 0:00:45
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local mJob = player:getMainJob()
    local ng_job = 0
    local id = tpz.effect.ATMA
    local atma = 91
    local mod1 = player:getCharVar("[atma]mod1")
    local val1 = player:getCharVar("[atma]val1")
    local mod2 = player:getCharVar("[atma]mod2")
    local val2 = player:getCharVar("[atma]val2")
    local mod3 = player:getCharVar("[atma]mod3")
    local val3 = player:getCharVar("[atma]val3")
    local hasKI = player:hasKeyItem(tpz.ki.ATMA_OF_THE_HATEFUL_STREAM)
    local pvpflag = player:getCharVar("pvp_flag")
    local cooldown = player:getLocalVar("[atma]cooldown")

    player:addStatusEffect(tpz.effect.HUNDRED_FISTS, 1, 0, 45)

    if (player:getCharVar("ng_job") ~= nil) then
        ng_job = player:getCharVar("ng_job")
    end

    if (hasKI and (val1 > 0 or val2 > 0 or val3 > 0) and 
        pvpflag == 1 and
        mJob == ng_job and
        cooldown < os.time()) then

        player:setLocalVar("[atma]mod1",mod1)
        player:setLocalVar("[atma]val1",val1)
        player:setLocalVar("[atma]mod2",mod2)
        player:setLocalVar("[atma]val2",val2)
	player:setLocalVar("[atma]mod3",mod3)
        player:setLocalVar("[atma]val3",val3)
        player:setLocalVar("[atma]cooldown", os.time() + 1800)

        player:addStatusEffect(id, atma, 3, 1800)
    end
end
