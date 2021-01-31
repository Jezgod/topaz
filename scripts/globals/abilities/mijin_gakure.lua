-----------------------------------
-- Ability: Mijin Gakure
-- Sacrifices user's life to deal damage to an enemy.
-- Obtained: Ninja Level 1
-- Recast Time: 1:00:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/keyitems")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (target:getObjType() == 1) then
        --player:timer(10000, function(player)
	--end)
        return tpz.msg.basic.CANNOT_ON_THAT_TARG, 0
    else
        return 0, 0
    end
end

function onUseAbility(player, target, ability)

    local dmg = (player:getHP() * 0.8) + (player:getMainLvl() / 0.5)
    local resist = applyPlayerResistance(player, nil, target, player:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT), 0, tpz.magic.ele.NONE)
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

    dmg = dmg * resist

    dmg = utils.stoneskin(target, dmg)
    target:takeDamage(dmg, player, tpz.attackType.SPECIAL, tpz.damageType.ELEMENTAL)

    --player:setLocalVar("MijinGakure", 1)
    player:setHP(1)

    if (hasKI and (val1 > 0 or val2 > 0 or val3 > 0) and pvpflag == 1 and cooldown < os.time()) then
        player:setLocalVar("[atma]mod1",mod1)
        player:setLocalVar("[atma]val1",val1)
        player:setLocalVar("[atma]mod2",mod2)
        player:setLocalVar("[atma]val2",val2)
	player:setLocalVar("[atma]mod3",mod3)
        player:setLocalVar("[atma]val3",val3)

        player:addStatusEffect(id, atma, 3, 1800)
    end

    return dmg

end
