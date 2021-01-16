-----------------------------------
-- Zone: Bastok Markets
--  NPC: Voidwatch Officer
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Bastok_Markets/IDs")
-----------------------------------

local opt1  = "Indigo.Stratum.Abyssite"
local opt2  = "Voidstone"
local opt3  = "Store.Merits"
local opt4  = "Exit"

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    player:SetEventNPC(npc:getID())
    player:PrintToPlayer(string.format("Abyssite Cost: 400 merits and 1,000,000 cruor"), 29)
    player:PrintToPlayer(string.format("Voidstone Cost: 100 merits and 100,000 cruor"), 29)
    player:PrintToPlayer(string.format("Choice? %s %s %s %s",opt1, opt2, opt3, opt4), 12)
end

function onMenuSelection(player, npc, Choice)
local ChoiceData = 
{
	{ choice = "Indigo.Stratum.Abyssite",              id =  370, 	var = 1,  merits = 400,	 cruor = 1000000 },
	{ choice = "Voidstone",                            id = 1539,	var = 2,  merits = 100,	 cruor =  100000 }
}

local cruor = player:getCurrency("cruor")
local merits = player:getMeritCount()
local storedmerits = player:getCharVar("[store]Merits")

        for _, v in pairs(ChoiceData) do
		if v.choice == Choice then
			if (player:hasKeyItem(v.id)) then
				player:PrintToPlayer(string.format("%s already obtained.", v.choice), 29)
				return
 			elseif (storedmerits >= v.merits and cruor >= v.cruor) then			 
				player:addKeyItem(v.id)
				player:setCharVar("[store]Merits", storedmerits - v.merits)
                                player:delCurrency("cruor", v.cruor)
				player:PrintToPlayer(string.format("Stored Merits Remaining: %u", player:getCharVar("[store]Merits")), 29)
    				player:messageSpecial(ID.text.KEYITEM_OBTAINED, v.id)
				return
			else
				player:PrintToPlayer(string.format("You do not meet the requirements to obtain the Key Item."), 14)
			end
                end
        end

    	if Choice == "Store.Merits" then
		if (merits > 0) then
		    player:addCharVar("[store]Merits", merits)
		    player:setMerits(0)
		    player:PrintToPlayer(string.format("Stored Merits: %u", player:getCharVar("[store]Merits")), 29)
             	else
		    player:PrintToPlayer(string.format("Your current merit count is zero."), 29)
		end
	end

        if Choice == "Exit" then
	    return
	end

        if Choice == "Canceled." then
		player:PrintToPlayer(string.format("Selection cancelled."), 29)
	end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end