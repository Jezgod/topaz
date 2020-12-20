-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Nomad Moogle
-- Type: Adventurer's Assistant
-- !pos 10.012 1.453 121.883 243
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------

local job_map =
{
	[tpz.job.WAR]	=	{ testimony = 1426 },
	[tpz.job.MNK]	=	{ testimony = 1427 },
	[tpz.job.WHM]	=	{ testimony = 1428 },
        [tpz.job.BLM]	=	{ testimony = 1429 },
	[tpz.job.RDM]	=	{ testimony = 1430 },
        [tpz.job.THF]	=	{ testimony = 1431 },
        [tpz.job.PLD]	=	{ testimony = 1432 },
	[tpz.job.DRK]	=	{ testimony = 1433 },
	[tpz.job.BST]	=	{ testimony = 1434 },
	[tpz.job.BRD]	=	{ testimony = 1435 },
	[tpz.job.RNG]	=	{ testimony = 1436 },
	[tpz.job.SAM]	=	{ testimony = 1437 },
	[tpz.job.NIN]	=	{ testimony = 1438 },
	[tpz.job.DRG]	=	{ testimony = 1439 },
        [tpz.job.SMN]	=	{ testimony = 1440 },
	[tpz.job.BLU]	=	{ testimony = 2331 },
	[tpz.job.COR]	=	{ testimony = 2332 },
        [tpz.job.PUP]	=	{ testimony = 2333 },
	[tpz.job.DNC]	=	{ testimony = 2556 },
        [tpz.job.SCH]	=	{ testimony = 2557 }
}

-- returns Lunar Abyssites
function getLunarAbyssiteTotal(player, abyssite)
    local LUNAR = 0
    if abyssite == "LUNAR" then
    	for ki = tpz.ki.LUNAR_ABYSSITE1, tpz.ki.LUNAR_ABYSSITE3 do
        	if player:hasKeyItem(ki) then
            		LUNAR = LUNAR + 1
        	end
    	end
        return LUNAR
    end
end

function onTrade(player, npc, trade)
    local meritCount = player:getMeritCount()
    local targ = player
    local abysstotal = getLunarAbyssiteTotal(targ, "LUNAR")
    local mJob = targ:getMainJob()
    local mLvl = targ:getMainLvl()
    local ng = 0
    local ng_job = 0
    local atma_token = 0
    local pJobMap = job_map[mJob]
    local hasItem = trade:hasItemQty(pJobMap.testimony, 1)
    local ki1 = tpz.ki.LUNAR_ABYSSITE1
    local ki2 = tpz.ki.LUNAR_ABYSSITE2
    local ki3 = tpz.ki.LUNAR_ABYSSITE3
   
    if (targ:getCharVar("ng") ~= nil) then
       ng = targ:getCharVar("ng")
    end

    if (targ:getCharVar("ng_job") ~= nil) then
       ng_job = targ:getCharVar("ng_job")
    end

    if (targ:getCharVar("atma_token") ~= nil) then
       atma_token = targ:getCharVar("atma_token")
    end

    if (mLvl == 75 and ng == 0 and ng_job == 0 and hasItem) then
        targ:tradeComplete()
    	targ:addKeyItem(ki1)
        targ:messageSpecial(ID.text.KEYITEM_OBTAINED,ki1)
        targ:setCharVar("ng", 1)
        targ:setCharVar("ng_job", mJob)
        targ:setCharVar("atma_token", atma_token + 1)
        targ:setLevel(1)
        targ:delExp(499)
        targ:PrintToPlayer( string.format("Job reset for NG+, but your power potential has increased."), 29 )
    elseif (mLvl == 75 and ng == 1 and ng_job == mJob and hasItem) then
        targ:tradeComplete()
    	targ:addKeyItem(ki2)
        targ:messageSpecial(ID.text.KEYITEM_OBTAINED,ki2)
        targ:setCharVar("ng", 2)
        targ:setCharVar("ng_job", mJob)
        targ:setCharVar("atma_token", atma_token + 1)
        targ:setLevel(1)
        targ:delExp(499)
        targ:PrintToPlayer( string.format("Job reset for NG++, but your power potential has increased further."), 29 )
    elseif (mLvl == 75 and ng == 1 and ng_job ~= mJob and hasItem) then
        targ:tradeComplete()
        targ:setCharVar("ng_job", mJob)
        targ:setLevel(1)
        targ:delExp(499)
        targ:PrintToPlayer( string.format("Job reset for NG+, but your power potential has increased."), 29 )
    elseif (mLvl == 75 and ng == 2 and ng_job == mJob and hasItem) then
        targ:tradeComplete()
    	targ:addKeyItem(ki3)
        targ:messageSpecial(ID.text.KEYITEM_OBTAINED,ki3)
        targ:setCharVar("ng", 3)
        targ:setCharVar("ng_job", mJob)
        targ:setCharVar("atma_token", atma_token + 1)
        targ:setLevel(1)
        targ:delExp(499)
        targ:PrintToPlayer( string.format("Job reset for NG+++, but your power potential has reached its maximum."), 29 )
    elseif (mLvl == 75 and ng == 2 and ng_job ~= mJob and hasItem) then
        targ:tradeComplete()
        targ:setCharVar("ng_job", mJob)
        targ:setLevel(1)
        targ:delExp(499)
        targ:PrintToPlayer( string.format("Job reset for NG++, but your power potential has increased further."), 29 )
    elseif (mLvl == 75 and ng == 3 and ng_job == mJob and hasItem) then
        targ:tradeComplete()
        targ:setCharVar("ng", 4)
        targ:setCharVar("ng_job", mJob)
        targ:setCharVar("atma_token", atma_token + 1)
        targ:PrintToPlayer( string.format("This job has been fully ascended to its final stage."), 29 )
    elseif (mLvl == 75 and ng == 3 and ng_job ~= mJob and hasItem) then
        targ:tradeComplete()
        targ:setCharVar("ng_job", mJob)
        targ:setLevel(1)
        targ:delExp(499)
        targ:PrintToPlayer( string.format("Job reset for NG+++, but your power potential has reached its maximum."), 29 )
    elseif (mLvl == 75 and ng == 4 and ng_job ~= mJob and hasItem) then
        targ:tradeComplete()
        targ:setCharVar("ng_job", mJob)
        targ:PrintToPlayer( string.format("Power potential has been transferred to a new job."), 29 )
    else
	targ:PrintToPlayer( string.format("Please try again when conditions are met."), 14 )
    end

    if (trade:hasItemQty(1127, 5) == true and trade:getGil() == 0 and trade:getItemCount() == 5 and meritCount > 2) then
        if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.NEW_WORLDS_AWAIT) == QUEST_ACCEPTED) then
            player:startEvent(10135)
        end
    elseif (trade:hasItemQty(2955, 5) == true and trade:getGil() == 0 and trade:getItemCount() == 5 and meritCount > 3) then
        if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.EXPANDING_HORIZONS) == QUEST_ACCEPTED) then
            player:startEvent(10136)
        end
    elseif (trade:hasItemQty(2955, 10) == true and trade:getGil() == 0 and trade:getItemCount() == 10 and meritCount > 4) then
        if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BEYOND_THE_STARS) == QUEST_ACCEPTED) then
            player:startEvent(10137)
        end
    elseif (trade:hasItemQty(2955, 1) == true and trade:hasItemQty(503, 1) == true and trade:getGil() == 0 and trade:getItemCount() == 2 and meritCount > 9) then
        if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.DORMANT_POWERS_DISLODGED) == QUEST_ACCEPTED) then
            player:startEvent(10138)
        end
    elseif (trade:hasItemQty(2956, 1) == true and trade:getGil() == 0 and trade:getItemCount() == 1 and player:getMainLvl() >= 96 and meritCount >= 15) then
	player:setMerits(meritCount - 15)
        player:addKeyItem(tpz.ki.HEART_OF_THE_BUSHIN)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.HEART_OF_THE_BUSHIN)
    end
end

function onTrigger(player, npc)
    if (player:hasKeyItem(tpz.ki.LIMIT_BREAKER) == false and player:getMainLvl() >= 75) then
        player:startEvent(10045, 75, 2, 10, 7, 30, 302895, 4095)
    elseif (player:getMainLvl() == 75 and player:levelCap() == 75 and MAX_LEVEL >= 80 and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.NEW_WORLDS_AWAIT) == QUEST_AVAILABLE) then
        player:startEvent(10045, 0, 1, 1, 0)
    elseif (player:getMainLvl() >= 76 and player:levelCap() == 80 and MAX_LEVEL >= 85 and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.EXPANDING_HORIZONS) == QUEST_AVAILABLE) then
        player:startEvent(10045, 0, 1, 2, 0)
    elseif (player:getMainLvl() >= 81 and player:levelCap() == 85 and MAX_LEVEL >= 90 and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BEYOND_THE_STARS) == QUEST_AVAILABLE) then
        player:startEvent(10045, 0, 1, 3, 0)
    elseif (player:getMainLvl() >= 86 and player:levelCap() == 90 and MAX_LEVEL >= 95 and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.DORMANT_POWERS_DISLODGED) == QUEST_AVAILABLE) then
        player:startEvent(10045, 0, 1, 4, 0)
    elseif (player:getMainLvl() >= 91 and player:levelCap() == 95 and MAX_LEVEL >= 99 and player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BEYOND_INFINITY) == QUEST_AVAILABLE) then
        player:startEvent(10045, 0, 1, 5, 0)
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.NEW_WORLDS_AWAIT) == QUEST_ACCEPTED) then
        player:startEvent(10045, 0, 1, 1, 1)
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.EXPANDING_HORIZONS) == QUEST_ACCEPTED) then
        player:startEvent(10045, 0, 1, 2, 1)
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BEYOND_THE_STARS) == QUEST_ACCEPTED) then
        player:startEvent(10045, 0, 1, 3, 1)
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.DORMANT_POWERS_DISLODGED) == QUEST_ACCEPTED) then
        player:startEvent(10045, 0, 1, 4, 1)
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BEYOND_INFINITY) == QUEST_ACCEPTED) then
        player:startEvent(10045, 0, 1, 5, 1) -- player:startEvent(10045, 0, 1, 6, 1)
    elseif (player:hasKeyItem(tpz.ki.LIMIT_BREAKER) == true and player:getMainLvl() >= 75) then
        player:startEvent(10045, 0, 1, 0, 0)
    else
        player:startEvent(10045, 0, 2, 0, 0)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local meritCount = player:getMeritCount()

    if (csid == 10045 and option == 4) then
        player:addKeyItem(tpz.ki.LIMIT_BREAKER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LIMIT_BREAKER)
    elseif (csid == 10045) then
        if (option == 5) then
            player:addQuest(JEUNO, tpz.quest.id.jeuno.NEW_WORLDS_AWAIT)
        elseif (option == 7 ) then
            player:addQuest(JEUNO, tpz.quest.id.jeuno.EXPANDING_HORIZONS)
        elseif (option == 9) then
            player:addQuest(JEUNO, tpz.quest.id.jeuno.BEYOND_THE_STARS)
        elseif (option == 11) then
            player:addQuest(JEUNO, tpz.quest.id.jeuno.DORMANT_POWERS_DISLODGED)
        end
    elseif (csid == 10135) then
        player:tradeComplete()
        player:setMerits(meritCount - 3)
        player:addFame(JEUNO, 50)
        player:levelCap(80)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.NEW_WORLDS_AWAIT)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_80)
    elseif (csid == 10136) then
        player:tradeComplete()
        player:setMerits(meritCount - 4)
        player:addFame(JEUNO, 50)
        player:levelCap(85)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.EXPANDING_HORIZONS)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_85)
    elseif (csid == 10137) then
        player:tradeComplete()
        player:setMerits(meritCount - 5)
        player:startEvent(10161) -- this is the scene that is suppose to play and you are suppose to have to do correctly inorder to level cap increase to 90
        player:addFame(JEUNO, 50)
        player:levelCap(90)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.BEYOND_THE_STARS)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_90)
    elseif (csid == 10138) then
        player:tradeComplete()
        player:setMerits(meritCount - 10)
        player:addFame(JEUNO, 50)
        player:levelCap(95)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.DORMANT_POWERS_DISLODGED)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_95)
        player:addKeyItem(tpz.ki.SOUL_GEM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SOUL_GEM)
    end
end
