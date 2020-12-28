-----------------------------------
--  Area: Northern San d'Oria
--  NPC: Suspicious Elvaan
--  Working 100%
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/settings")
-----------------------------------

local job_map =
{
	[tpz.job.MNK]	=	{relic = {final = 18264, name = "SPHARAI",       base = 18260, ore1 = 1261, ore2 = 1255, qty1 = 48, qty2 = 48}},
        [tpz.job.PUP]	=	{relic = {final = 18264, name = "SPHARAI",       base = 18260, ore1 = 1261, ore2 = 1255, qty1 = 48, qty2 = 48}},
	[tpz.job.RDM]	=	{relic = {final = 18276, name = "EXCALIBUR",     base = 18272, ore1 = 1261, ore2 = 1255, qty1 = 48, qty2 = 48}},
	[tpz.job.PLD]	=	{relic = {final = 18276, name = "EXCALIBUR",     base = 18272, ore1 = 1261, ore2 = 1255, qty1 = 48, qty2 = 48}},
	[tpz.job.BLU]	=	{relic = {final = 18276, name = "EXCALIBUR",     base = 18272, ore1 = 1261, ore2 = 1255, qty1 = 48, qty2 = 48}},
	[tpz.job.WAR]	=	{relic = {final = 18294, name = "BRAVURA",       base = 18290, ore1 = 1261, ore2 = 1255, qty1 = 48, qty2 = 48}},
        [tpz.job.DRK]	=	{relic = {final = 18306, name = "APOCALYPSE",    base = 18302, ore1 = 1261, ore2 = 1255, qty1 = 48, qty2 = 48}},
        [tpz.job.NIN]	=	{relic = {final = 18312, name = "KIKOKU",        base = 18308, ore1 = 1259, ore2 = 1257, qty1 = 48, qty2 = 48}},
	[tpz.job.WHM]	=	{relic = {final = 18324, name = "MJOLLNIR",      base = 18320, ore1 = 1259, ore2 = 1257, qty1 = 48, qty2 = 48}},
	[tpz.job.RNG]	=	{relic = {final = 18348, name = "YOICHINOYUMI",  base = 18344, ore1 = 1260, ore2 = 1256, qty1 = 48, qty2 = 48}},
	[tpz.job.SAM]	=	{relic = {final = 18348, name = "YOICHINOYUMI",  base = 18344, ore1 = 1260, ore2 = 1256, qty1 = 48, qty2 = 48}},
	[tpz.job.BRD]	=	{relic = {final = 18342, name = "GJALLAHORN",    base = 18338, ore1 = 1262, ore2 = 1261, qty1 = 48, qty2 = 48}}
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
	local sum1 = (qOne + qTwo) / 4 + 1
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
	    	trade:hasItemQty(pJobMap.relic.ore1, qOne / 4) and
                trade:hasItemQty(pJobMap.relic.ore2, qTwo / 4) and
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
	player:PrintToPlayer( string.format("Obtain stage five Relics here.  Trading the first stage Relic cuts the ore cost in half."), 29)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end