-----------------------------------
--  Area: Pashhow Marshlands
--  NPC: Suspicious Hume
--  Working 100%
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands/IDs")
require("scripts/globals/settings")
-----------------------------------

local mythic_map =
{
	[tpz.job.WAR] = {mythic = {final = 18991, base = 18971, name = "CONQUEROR",     ore1 = 1259, ore2 = 1257}},
	[tpz.job.MNK] = {mythic = {final = 18992, base = 18972, name = "GLANZFAUST",    ore1 = 1261, ore2 = 1255}},
	[tpz.job.WHM] = {mythic = {final = 18993, base = 18973, name = "YAGRUSH",       ore1 = 1261, ore2 = 1262}},
	[tpz.job.BLM] = {mythic = {final = 18994, base = 18974, name = "LAEVATEINN",    ore1 = 1259, ore2 = 1257}},
	[tpz.job.RDM] = {mythic = {final = 18995, base = 18975, name = "MURGLEIS",      ore1 = 1259, ore2 = 1257}},
	[tpz.job.THF] = {mythic = {final = 18996, base = 18976, name = "VAJRA",         ore1 = 1261, ore2 = 1255}},
	[tpz.job.PLD] = {mythic = {final = 18997, base = 18977, name = "BURTGANG",      ore1 = 1261, ore2 = 1255}},
	[tpz.job.DRK] = {mythic = {final = 18998, base = 18978, name = "LIBERATOR",     ore1 = 1261, ore2 = 1255}},
	[tpz.job.BST] = {mythic = {final = 18999, base = 18979, name = "AYMUR",         ore1 = 1262, ore2 = 1258}},
	[tpz.job.BRD] = {mythic = {final = 19000, base = 18980, name = "CARNWENHAN",    ore1 = 1259, ore2 = 1257}},
	[tpz.job.RNG] = {mythic = {final = 19001, base = 18981, name = "GASTRAPHETES",  ore1 = 1257, ore2 = 1259}},
	[tpz.job.SAM] = {mythic = {final = 19002, base = 18982, name = "KOGARASUMARU",  ore1 = 1262, ore2 = 1258}},
	[tpz.job.NIN] = {mythic = {final = 19003, base = 18983, name = "NAGI",          ore1 = 1259, ore2 = 1257}},
	[tpz.job.DRG] = {mythic = {final = 19004, base = 18984, name = "RYUNOHIGE",     ore1 = 1261, ore2 = 1255}},
	[tpz.job.SMN] = {mythic = {final = 19005, base = 18985, name = "NIRVANA",       ore1 = 1261, ore2 = 1255}},
	[tpz.job.BLU] = {mythic = {final = 19006, base = 18986, name = "TIZONA",        ore1 = 1256, ore2 = 1260}},
	[tpz.job.COR] = {mythic = {final = 19007, base = 18987, name = "DEATH PENALTY", ore1 = 1262, ore2 = 1258}},
	[tpz.job.PUP] = {mythic = {final = 19008, base = 18988, name = "KENKONKEN",     ore1 = 1262, ore2 = 1258}},
	[tpz.job.DNC] = {mythic = {final = 18989, base = 18969, name = "TERPSICHORE",   ore1 = 1256, ore2 = 1260}},
	[tpz.job.SCH] = {mythic = {final = 18990, base = 18970, name = "TUPSIMATI",     ore1 = 1262, ore2 = 1258}}
}

function onTrade(player,npc,trade)
	local pLevel = player:getMainLvl()
	local mJob = player:getMainJob()
	local pJobMap = mythic_map[mJob]
	local hasBase = trade:hasItemQty(pJobMap.mythic.base, 1)
        local hasFinal = player:hasItem(pJobMap.mythic.final)
	local pIS = player:getCurrency("imperial_standing")
	local rIS = 1000000
	local item = 0
	local qOne = 48
	local qTwo = 48
	local sum1 = (qOne + qTwo) / 12 + 1
	local sum2 = (qOne + qTwo)
        local name = pJobMap.mythic.name

        if (pIS < rIS) then
  	        player:PrintToPlayer("Mythics require 1,000,000 Imperial Standing to obtain.", 29)
                player:PrintToPlayer(string.format("You currently possess %u.", pIS), 29)
                return 1
        end

        if (pLevel < 75) then
  	        player:PrintToPlayer("Mythics require Level 75 to obtain.", 29)
                return 1
        end

        if hasFinal then
		player:PrintToPlayer("You already possess this Mythic.", 29)
                return 1
	end

        if hasBase then
	    if (pLevel == 75 and pIS >= rIS and
	    	trade:hasItemQty(pJobMap.mythic.ore1, qOne / 10) and
                trade:hasItemQty(pJobMap.mythic.ore2, qTwo / 10) and
                trade:getGil() == 0 and
                trade:getItemCount() == sum1)  then

	    	item = pJobMap.mythic.final
                player:tradeComplete()
                player:addItem(item)
                player:delCurrency("imperial_standing", rIS)
                player:PrintToPlayer(string.format("Congratulations, you have just earned the %s Mythic.", name), 29)
                player:messageSpecial(ID.text.ITEM_OBTAINED,item)
	    else
            	player:PrintToPlayer("Please trade the appropriate items for your desired Mythic.", 29)
            end
        else 
	    if (pLevel == 75 and pIS >= rIS and
	        trade:hasItemQty(pJobMap.mythic.ore1, qOne) and
                trade:hasItemQty(pJobMap.mythic.ore2, qTwo) and
                trade:getGil() == 0 and
                trade:getItemCount() == sum2) then

                item = pJobMap.mythic.final
                player:tradeComplete()
                player:addItem(item)
                player:delCurrency("imperial_standing", rIS)
                player:PrintToPlayer(string.format("Congratulations, you have just earned the %s Mythic.", name), 29)
                player:messageSpecial(ID.text.ITEM_OBTAINED,item)
            else
               player:PrintToPlayer("Please trade the appropriate items for your desired Mythic.", 29)
            end
        end
end

function onTrigger(player,npc)
	player:PrintToPlayer( string.format("Obtain stage five Mythics here.  Trading the first stage Mythic cuts the ore cost in half."), 29)
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end