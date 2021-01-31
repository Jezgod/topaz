-----------------------------------
-- Ability: Spirit Surge
-- Adds your wyvern's strength to your own.
-- Obtained: Dragoon Level 1
-- Recast Time: 1:00:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/keyitems")
-----------------------------------

function onAbilityCheck(player, target, ability)
    -- The wyvern must be present in order to use Spirit Surge
    if (target:getPet() == nil) then
        return tpz.msg.basic.REQUIRES_A_PET, 0
    else
        return 0, 0
    end
end

function onUseAbility(player, target, ability)
    -- Spirit Surge increases dragoon's MAX HP increases by 25% of wyvern MaxHP
    -- bg wiki says 25% ffxiclopedia says 15%, going with 25 for now
    local mhp_boost = target:getPet():getMaxHP()*0.25
    -- Dragoon gets all of wyverns TP when using Spirit Surge
    local pet = player:getPet()
    local petTP = pet:getTP()
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

    target:addTP(petTP) --add pet TP to dragoon
    pet:delTP(petTP) -- remove TP from pet
    -- Spirit Surge increases dragoon's Strength
    local strBoost = 0
    if (target:getMainJob() == tpz.job.DRG) then
        strBoost = (1 + target:getMainLvl()/5) -- Use Mainjob Lvl
    else
        strBoost = (1 + target:getSubLvl()/5)  -- Use Subjob Lvl
    end

    local duration = 60

    target:despawnPet()
    -- All Jump recast times are reset
    target:resetRecast(tpz.recast.ABILITY, 158) -- Jump
    target:resetRecast(tpz.recast.ABILITY, 159) -- High Jump
    target:resetRecast(tpz.recast.ABILITY, 160) -- Super Jump

    target:addStatusEffect(tpz.effect.SPIRIT_SURGE, mhp_boost, 0, duration, 0, strBoost)

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
