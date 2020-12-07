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
	[tpz.job.WAR] = {items = {weapon = 18991, base = 18971, name = "CONQUEROR",     ore1 = 1259, ore2 = 1257}},
	[tpz.job.MNK] = {items = {weapon = 18992, base = 18972, name = "GLANZFAUST",    ore1 = 1261, ore2 = 1255}},
	[tpz.job.WHM] = {items = {weapon = 18993, base = 18973, name = "YAGRUSH",       ore1 = 1261, ore2 = 1262}},
	[tpz.job.BLM] = {items = {weapon = 18994, base = 18974, name = "LAEVATEINN",    ore1 = 1259, ore2 = 1257}},
	[tpz.job.RDM] = {items = {weapon = 18995, base = 18975, name = "MURGLEIS",      ore1 = 1259, ore2 = 1257}},
	[tpz.job.THF] = {items = {weapon = 18996, base = 18976, name = "VAJRA",         ore1 = 1261, ore2 = 1255}},
	[tpz.job.PLD] = {items = {weapon = 18997, base = 18977, name = "BURTGANG",      ore1 = 1261, ore2 = 1255}},
	[tpz.job.DRK] = {items = {weapon = 18998, base = 18978, name = "LIBERATOR"      ore1 = 1261, ore2 = 1255}},
	[tpz.job.BST] = {items = {weapon = 18999, base = 18979, name = "AYMUR",         ore1 = 1262, ore2 = 1258}},
	[tpz.job.BRD] = {items = {weapon = 19000, base = 18980, name = "CARNWENHAN",    ore1 = 1259, ore2 = 1257}},
	[tpz.job.RNG] = {items = {weapon = 19001, base = 18981, name = "GASTRAPHETES",  ore1 = 1257, ore2 = 1259}},
	[tpz.job.SAM] = {items = {weapon = 19002, base = 18982, name = "KOGARASUMARU",  ore1 = 1262, ore2 = 1258}},
	[tpz.job.NIN] = {items = {weapon = 19003, base = 18983, name = "NAGI",          ore1 = 1259, ore2 = 1257}},
	[tpz.job.DRG] = {items = {weapon = 19004, base = 18984, name = "RYUNOHIGE",     ore1 = 1261, ore2 = 1255}},
	[tpz.job.SMN] = {items = {weapon = 19005, base = 18985, name = "NIRVANA",       ore1 = 1261, ore2 = 1255}},
	[tpz.job.BLU] = {items = {weapon = 19006, base = 18986, name = "TIZONA",        ore1 = 1256, ore2 = 1260}},
	[tpz.job.COR] = {items = {weapon = 19007, base = 18987, name = "DEATH PENALTY", ore1 = 1262, ore2 = 1258}},
	[tpz.job.PUP] = {items = {weapon = 19008, base = 18988, name = "KENKONKEN",     ore1 = 1262, ore2 = 1258}},
	[tpz.job.DNC] = {items = {weapon = 18989, base = 18969, name = "TERPSICHORE",   ore1 = 1256, ore2 = 1260}},
	[tpz.job.SCH] = {items = {weapon = 18990, base = 18970, name = "TUPSIMATI",     ore1 = 1262, ore2 = 1258}}
}

function onTrade(player,npc,trade)
	local mjob = player:getMainJob()
        local pJobMap = mythic_map[mjob]
        local pLevel = player:getMainLvl()
        local currency = "imperial_standing"
	local pIS = player:getCurrency(currency)
        local rIS = 1000000
        local item1Count = 50
        local item2Count = 50

	if (trade:getItemCount() ~= 24 or trade:getGil() ~= 0) then
		player:messageSpecial(ID.text.NOTHING_HAPPENS)
	
	--WAR MYTHIC: CONQUEROR (THUNDER/WIND)
	elseif (mjob == tpz.job.WAR and pLevel == 75 and pIS >= rIS and 
                trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

	--MNK MYTHIC: GLANZFAUST (LIGHT/FIRE)
	elseif (mjob == tpz.job.MNK and pLevel == 75 and pIS >= rIS and 
                trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --WHM MYTHIC: YAGRUSH (LIGHT/DARK)
	elseif (mjob == tpz.job.WHM and pLevel == 75 and pIS >= rIS and 
		trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --BLM MYTHIC: LAEVATEINN (THUNDER/WIND)
	elseif (mjob == tpz.job.BLM and pLevel == 75 and pIS >= rIS and 
		trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --RDM MYTHIC: MURGLEIS (THUNDER/WIND)
	elseif (mjob == tpz.job.RDM and pLevel == 75 and pIS >= rIS and 
		trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --THF MYTHIC: VAJRA (LIGHT/FIRE)
	elseif (mjob == tpz.job.THF and pLevel == 75 and pIS >= rIS and 
		trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --PLD MYTHIC: BURTGANG (LIGHT/FIRE)
	elseif (mjob == tpz.job.PLD and pLevel == 75 and pIS >= rIS and 
		trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --DRK MYTHIC: LIBERATOR (LIGHT/FIRE)
	elseif (mjob == tpz.job.DRK and pLevel == 75 and pIS >= rIS and 
		trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --BST MYTHIC: AYMUR (DARK/EARTH)
	elseif (mjob == tpz.job.BST and pLevel == 75 and pIS >= rIS and 
		trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --BRD MYTHIC: CARNWENHAN (THUNDER/WIND)
	elseif (mjob == tpz.job.BRD and pLevel == 75 and pIS >= rIS and 
		trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --RNG MYTHIC: GASTRAPHETES (THUNDER/WIND)
	elseif (mjob == tpz.job.RNG and pLevel == 75 and pIS >= rIS and 
                trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)
 
        --SAM MYTHIC: KOGARASUMARU (DARK/EARTH)
	elseif (mjob == tpz.job.SAM and pLevel == 75 and pIS >= rIS and 
                trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --NIN MYTHIC: NAGI (THUNDER/WIND)
	elseif (mjob == tpz.job.NIN and pLevel == 75 and pIS >= rIS and 
                trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --DRG MYTHIC: RYUNOHIGE (LIGHT/FIRE)
	elseif (mjob == tpz.job.DRG and pLevel == 75 and pIS >= rIS and 
                trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --SMN MYTHIC: NIRVANA (LIGHT/FIRE)
	elseif (mjob == tpz.job.SMN and pLevel == 75 and pIS >= rIS and 
                trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --BLU MYTHIC: TIZONA (ICE/WATER)
	elseif (mjob == tpz.job.BLU and pLevel == 75 and pIS >= rIS and 
                trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --COR MYTHIC: DEATH PENALTY (DARK/EARTH)
	elseif (mjob == tpz.job.COR and pLevel == 75 and pIS >= rIS and 
                trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --PUP MYTHIC: KENKONKEN (DARK/EARTH)
	elseif (mjob == tpz.job.PUP and pLevel == 75 and pIS >= rIS and 
                trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --DNC MYTHIC: TERPSICHORE (ICE/WATER)
	elseif (mjob == tpz.job.DNC and pLevel == 75 and pIS >= rIS and 
                trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)

        --SCH MYTHIC: TUPSIMATI (DARK/EARTH)
	elseif (mjob == tpz.job.SCH and pLevel == 75 and pIS >= rIS and 
                trade:hasItemQty(pJobMap.items.ore1,item1Count) and 
		trade:hasItemQty(pJobMap.items.ore2,item2Count) and
		trade:getItemCount() == 24 and
            	trade:getGil() == 0) then
              	
		player:tradeComplete()
    		player:addItem(pJobMap.items.weapon)
       		player:delCurrency(currency,rIS)
    		player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.items.weapon)
        
        else
		player:messageSpecial(ID.text.NOTHING_HAPPENS)
	end
end

function onTrigger(player,npc)
	player:PrintToPlayer( string.format("Obtain Mythic Weapons Here...") )
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end