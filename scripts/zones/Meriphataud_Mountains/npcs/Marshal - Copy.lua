-----------------------------------
-- Area: Meriphataud Mountains
--  NPC: Marshal
-- Type: Infamy Exchange
-- !pos -10 -16 203 119
-----------------------------------

local opt1  = "CP"
local opt2  = "IS"
local opt3  = "AN"
local opt4  = "CRUOR"
local opt5  = "BAYLD"

function onTrade(player, npc, trade)
    local pNation = player:getNation()
    local sandyCP = player:getConquestPointRatio(0)
    local bastyCP = player:getConquestPointRatio(1)
    local windyCP = player:getConquestPointRatio(2)
    local sandyIS = player:getImperialPointRatio(0)
    local bastyIS = player:getImperialPointRatio(1)
    local windyIS = player:getImperialPointRatio(2)
    local sandyAN = player:getAlliedPointRatio(0)
    local bastyAN = player:getAlliedPointRatio(1)
    local windyAN = player:getAlliedPointRatio(2)
    local sandyCR = player:getCruorRatio(0)
    local bastyCR = player:getCruorRatio(1)
    local windyCR = player:getCruorRatio(2)
    local sandyBY = player:getBayldRatio(0)
    local bastyBY = player:getBayldRatio(1)
    local windyBY = player:getBayldRatio(2)
    local sandyTOT = sandyCP + sandyIS + sandyAN + sandyCR + sandyBY
    local bastyTOT = bastyCP + bastyIS + bastyAN + bastyCR + bastyBY
    local windyTOT = windyCP + windyIS + windyAN + windyCR + windyBY
    local globalTOT = sandyTOT + bastyTOT + windyTOT
    local pglobalTOT = 0
    local choice = player:getLocalVar("convert_infamy")
    local pInfamy = player:getCurrency("infamy")
    local infamy
    local cp
    local is
    local an
    local cruor
    local bayld

    if (pNation == 0) then
        pglobalTOT = math.floor((sandyTOT * 100) / globalTOT)
    elseif (pNation == 1) then
        pglobalTOT = math.floor((bastyTOT * 100) / globalTOT)
    else
        pglobalTOT = math.floor((windyTOT * 100) / globalTOT)
    end
    
    player:PrintToPlayer(string.format("%i %i %i", sandyTOT, bastyTOT, windyTOT), 29) 
    player:PrintToPlayer(string.format("Nation: %i", pglobalTOT), 29) 

    if (choice == 0) then
        player:PrintToPlayer( string.format("You first need to select the currency to convert Infamy into."), 29 )
    elseif (choice == 1 and trade:getGil() <= pInfamy and trade:getItemCount() == 1) then
            infamy = trade:getGil()
            cp = infamy
            cp = cp * pglobalTOT
            player:addCP(cp)
            player:delCurrency("infamy",infamy)
            player:tradeComplete()
            player:PrintToPlayer( string.format("Added %i to your Conquest Point total.", cp), 29 )
    elseif (choice == 2 and trade:getGil() <= pInfamy and trade:getItemCount() == 1) then
            infamy = trade:getGil()
            is = infamy
            is = is * pglobalTOT
            player:addCurrency("imperial_standing", is)
            player:delCurrency("infamy",infamy)
            player:tradeComplete()
            player:PrintToPlayer( string.format("Added %i to your Imperial Standing total.", is), 29 )
    elseif (choice == 3 and trade:getGil() <= pInfamy and trade:getItemCount() == 1) then
            infamy = trade:getGil()
            an = infamy
            an = an * pglobalTOT
            player:addCurrency("allied_notes", an)
            player:delCurrency("infamy",infamy)
            player:tradeComplete()
            player:PrintToPlayer( string.format("Added %i to your Allied Notes total.", an), 29 )
    elseif (choice == 4 and trade:getGil() <= pInfamy and trade:getItemCount() == 1) then
            infamy = trade:getGil()
            cruor = infamy
            cruor = cruor * pglobalTOT
            player:addCurrency("cruor", cruor)
            player:delCurrency("infamy",infamy)
            player:tradeComplete()
            player:PrintToPlayer( string.format("Added %i to your Cruor total.", cruor), 29 )
    elseif (choice == 5 and trade:getGil() <= pInfamy and trade:getItemCount() == 1) then
            infamy = trade:getGil()
            bayld = infamy
            bayld = bayld * pglobalTOT
            player:addCurrency("bayld", bayld)
            player:delCurrency("infamy",infamy)
            player:tradeComplete()
            player:PrintToPlayer( string.format("Added %i to your Bayld total.", bayld), 29 )
    else
           player:PrintToPlayer( string.format("Please try again."), 29 )
    end
end

function onTrigger(player,npc)  
    player:SetEventNPC(npc:getID());
    player:PrintToPlayer(string.format("Result? %s %s %s %s %s",opt1, opt2, opt3, opt4, opt5), 12);
    player:PrintToPlayer( string.format("Choose currency to convert Infamy into."), 29 )
end

function onMenuSelection(player, npc, Choice)
local data = 
{
	{ choice = "CP",             id = 1,	currency =  0                  },
	{ choice = "IS",             id = 2, 	currency = "imperial_standing" },
        { choice = "AN",             id = 3, 	currency = "allied_notes"      },
 	{ choice = "CRUOR",          id = 4, 	currency = "cruor"             },
	{ choice = "BAYLD",          id = 5, 	currency = "bayld"             },
}

	for _, v in pairs(data) do
		if v.choice == Choice then
			if (v.id == 1) then
				player:setLocalVar("convert_infamy",v.id)
				return
			elseif (v.id == 2) then
				player:setLocalVar("convert_infamy",v.id)
				return
			elseif (v.id == 3) then
				player:setLocalVar("convert_infamy",v.id)
				return
			elseif (v.id == 4) then
				player:setLocalVar("convert_infamy",v.id)
				return
			elseif (v.id == 5) then
				player:setLocalVar("convert_infamy",v.id)
				return
			else
				player:PrintToPlayer(("Please try again."), 29)
			end
                end
        end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
