-----------------------------------
--  Area: Port Bastok
--  NPC: Suspicious Galka
--  Working 100%
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/settings");
-----------------------------------

local job_map =
{
	[tpz.job.RDM]	=	{relic = {final = 18270, name = "MANDAU",        base = 18266, ore1 = 1262, ore2 = 1258, qty1 = 48, qty2 = 48}},
	[tpz.job.THF]	=	{relic = {final = 18270, name = "MANDAU",        base = 18266, ore1 = 1262, ore2 = 1258, qty1 = 48, qty2 = 48}},
	[tpz.job.BRD]	=	{relic = {final = 18270, name = "MANDAU",        base = 18266, ore1 = 1262, ore2 = 1258, qty1 = 48, qty2 = 48}},
        [tpz.job.DNC]	=	{relic = {final = 18270, name = "MANDAU",        base = 18266, ore1 = 1262, ore2 = 1258, qty1 = 48, qty2 = 48}},
	[tpz.job.WAR]	=	{relic = {final = 18282, name = "RAGNAROK",      base = 18278, ore1 = 1261, ore2 = 1255, qty1 = 48, qty2 = 48}},
        [tpz.job.PLD]	=	{relic = {final = 18282, name = "RAGNAROK",      base = 18278, ore1 = 1261, ore2 = 1255, qty1 = 48, qty2 = 48}},
        [tpz.job.DRK]	=	{relic = {final = 18282, name = "RAGNAROK",      base = 18278, ore1 = 1261, ore2 = 1255, qty1 = 48, qty2 = 48}},
	[tpz.job.BST]	=	{relic = {final = 18288, name = "GUTTLER",       base = 18284, ore1 = 1262, ore2 = 1258, qty1 = 48, qty2 = 48}},
	[tpz.job.DRG]	=	{relic = {final = 18300, name = "GUNGNIR",       base = 18296, ore1 = 1260, ore2 = 1256, qty1 = 48, qty2 = 48}},
	[tpz.job.SAM]	=	{relic = {final = 18318, name = "AMANOMURAKUMO", base = 18314, ore1 = 1259, ore2 = 1257, qty1 = 48, qty2 = 48}},
	[tpz.job.BLM]	=	{relic = {final = 18330, name = "CLAUSTRUM",     base = 18326, ore1 = 1260, ore2 = 1256, qty1 = 48, qty2 = 48}},
	[tpz.job.SMN]	=	{relic = {final = 18330, name = "CLAUSTRUM",     base = 18326, ore1 = 1260, ore2 = 1256, qty1 = 48, qty2 = 48}},
        [tpz.job.SCH]	=	{relic = {final = 18330, name = "CLAUSTRUM",     base = 18326, ore1 = 1260, ore2 = 1256, qty1 = 48, qty2 = 48}},
	[tpz.job.RNG]	=	{relic = {final = 18336, name = "ANNIHILATOR",   base = 18332, ore1 = 1259, ore2 = 1257, qty1 = 48, qty2 = 48}},
	[tpz.job.PLD]	=	{relic = {final = 15070, name = "AEGIS",         base = 15066, ore1 = 1262, ore2 = 1261, qty1 = 48, qty2 = 48}}
}

function onTrade(player,npc,trade)
	local pLevel = player:getMainLvl()
	local mJob = player:getMainJob()
	local pJobMap = job_map[mJob]
	local hasBase = trade:hasItemQty(pJobMap.relic.base, 1)
        local hasFinal = player:hasItem(pJobMap.relic.final)
	local pCP = player:getCP()
	local rCP = 1000000
	local item = 0
	local qOne = pJobMap.relic.qty1
	local qTwo = pJobMap.relic.qty2
	local sum1 = (qOne + qTwo) / 12 + 1
	local sum2 = (qOne + qTwo)
        local name = pJobMap.relic.name

        if (pCP < rCP) then
  	        player:PrintToPlayer("Relics require 1,000,000 Conquest Points to obtain.", 29)
                player:PrintToPlayer(string.format("You currently possess %u.", pCP), 29)
                return 1
        end

        if (pLevel < 75) then
  	        player:PrintToPlayer("Relics require Level 75 to obtain.", 29)
                return 1
        end

        if hasFinal then
		player:PrintToPlayer("You already possess this Relic.", 29)
                return 1
	end

        if hasBase then
	    if (pLevel == 75 and pCP >= rCP and
	    	trade:hasItemQty(pJobMap.relic.ore1, qOne / 12) and
                trade:hasItemQty(pJobMap.relic.ore2, qTwo / 12) and
                trade:getGil() == 0 and
                trade:getItemCount() == sum1)  then

	    	item = pJobMap.relic.final
                player:tradeComplete()
                player:addItem(item)
                player:delCP(rCP)
                player:PrintToPlayer(string.format("Congratulations, you have just earned the %s Relic.", name), 29)
                player:messageSpecial(ID.text.ITEM_OBTAINED,item)
	    else
            	player:PrintToPlayer("Please trade the appropriate items for your desired Relic.", 29)
            end
        else 
	    if (pLevel == 75 and pCP >= rCP and
	        trade:hasItemQty(pJobMap.relic.ore1, qOne) and
                trade:hasItemQty(pJobMap.relic.ore2, qTwo) and
                trade:getGil() == 0 and
                trade:getItemCount() == sum2) then

                item = pJobMap.relic.final
                player:tradeComplete()
                player:addItem(item)
                player:delCP(rCP)
                player:PrintToPlayer(string.format("Congratulations, you have just earned the %s Relic.", name), 29)
                player:messageSpecial(ID.text.ITEM_OBTAINED,item)
            else
               player:PrintToPlayer("Please trade the appropriate items for your desired Relic.", 29)
            end
        end
end

function onTrigger(player,npc)
	player:PrintToPlayer( string.format("Obtain stage five Relics here.  Trading the first stage Relic reduces the ore cost."), 29)
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;