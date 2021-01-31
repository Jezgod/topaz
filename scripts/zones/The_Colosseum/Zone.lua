-----------------------------------
--
-- Zone: The_Colosseum
--
-----------------------------------
local ID = require("scripts/zones/The_Colosseum/IDs")
require("scripts/globals/status")
require("scripts/globals/ability")
require("scripts/globals/teleports")
require("scripts/globals/msg")
-----------------------------------

local job_map =
{
	[tpz.job.WAR] = {effect = tpz.effect.MIGHTY_STRIKES},
	[tpz.job.MNK] = {effect = tpz.effect.HUNDRED_FISTS},
	[tpz.job.WHM] = {effect = 0},
	[tpz.job.BLM] = {effect = tpz.effect.MANAFONT},	
	[tpz.job.RDM] = {effect = tpz.effect.CHAINSPELL},
	[tpz.job.THF] = {effect = tpz.effect.PERFECT_DODGE},
	[tpz.job.PLD] = {effect = tpz.effect.INVINCIBLE},
	[tpz.job.DRK] = {effect = tpz.effect.BLOOD_WEAPON},
	[tpz.job.BST] = {effect = 0},
	[tpz.job.BRD] = {effect = tpz.effect.SOUL_VOICE},
	[tpz.job.RNG] = {effect = 0},
	[tpz.job.SAM] = {effect = tpz.effect.MEIKYO_SHISUI},
	[tpz.job.NIN] = {effect = 0},
	[tpz.job.DRG] = {effect = 0},
	[tpz.job.SMN] = {effect = tpz.effect.ASTRAL_FLOW},
	[tpz.job.BLU] = {effect = tpz.effect.AZURE_LORE},
	[tpz.job.COR] = {effect = 0},
	[tpz.job.PUP] = {effect = 0},
	[tpz.job.DNC] = {effect = tpz.effect.TRANCE},
	[tpz.job.SCH] = {effect = tpz.effect.TABULA_RASA},
}

function onInitialize(zone)
end

function onZoneIn(player,prevZone)
    local cs = -1
    local mjob = player:getMainJob()
    local jobmap = job_map[mjob]
    local nation = 0
    local nationByNum = {
	[0] = "None",
        [1] = "Player",
        [2] = "San d'Oria",
        [3] = "Bastok",
        [4] = "Windurst",
    }
	
    -- turn on stylelock
    -- player:lockstyleOn()

    -- get nation
    nation = player:getNation()
    allegiance = nation + 2

    -- set nation  
    player:setAllegiance( allegiance )
    player:PrintToPlayer( string.format("Allegiance set to %s", nationByNum[allegiance]))
    
    -- prepare for war
    -- player:addStatusEffect(tpz.effect.SJ_RESTRICTION, 1, 3, 300)
    -- player:messageBasic(tpz.msg.basic.UNABLE_TO_ACCESS_SJ)
    player:delStatusEffect(jobmap.effect)
    player:dispelAllStatusEffect()
    player:eraseAllStatusEffect()
    player:addRecast(tpz.recast.ABILITY, 0, 300)
    player:addStatusEffect(tpz.effect.BIND,1,0,20)
    player:setHP(player:getMaxHP())
    player:setMP(player:getMaxMP())
    printf("Job : %i",mjob)
    printf("Ability : %i",jobmap.effect)

--[[
    if (player:hasStatusEffect(tpz.effect.SIGNET)) then
    	player:delStatusEffect(tpz.effect.SIGNET)
    	player:addStatusEffect(tpz.effect.SANCTION,0,0,300)
    elseif (player:hasStatusEffect(tpz.effect.SIGIL)) then
    	player:delStatusEffect(tpz.effect.SIGIL)
    	player:addStatusEffect(tpz.effect.SANCTION,0,0,300)
    else
	player:addStatusEffect(tpz.effect.SANCTION,0,0,300)
    end
--]]
    player:delStatusEffectsByFlag(tpz.effectFlag.INFLUENCE, true)
    player:addStatusEffect(tpz.effect.SANCTION,0,0,300)

    player:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.HOME_NATION, 0, 300)
    return cs
end

function onRegionEnter(player,region)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end