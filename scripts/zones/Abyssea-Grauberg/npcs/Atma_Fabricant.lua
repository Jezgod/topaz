-----------------------------------
-- Zone: Abyssea - Grauberg
--  NPC: Atma Fabricant
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Abyssea-Grauberg/IDs")
-----------------------------------

local opt1  = "the.Despot"
local opt2  = "the.Solitary.One"
local opt3  = "the.Winged.Gloom"
local opt4  = "the.Sea.Daughter"    
local opt5  = "the.Foe.Flayer"    
local opt6  = "the.Endless.Nightmare"
local opt7  = "the.Sundering.Slash"   
local opt8  = "Entwined.Serpents"   
local opt9  = "the.Horned.Beast"   
local opt10 = "Aquatic.Ardor"
local opt11 = "the.Fallen.One"
local opt12 = "Fires.and.Flares" 

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    --player:startEvent(2182)
    player:SetEventNPC(npc:getID())

    player:PrintToPlayer(string.format("Atma.of? %s %s %s %s %s %s %s Next>",opt1, opt2, opt3, opt4, opt5, opt6, opt7), 12)
end

function onMenuSelection(player, npc, Choice)
local AtmaData = 
{
	{ choice = "the.Despot",        		id = 1365 },
	{ choice = "the.Solitary.One",         		id = 1366 },
	{ choice = "the.Winged.Gloom",    		id = 1367 },
	{ choice = "the.Sea.Daughter",    	 	id = 1368 },
	{ choice = "the.Foe.Flayer",  	 		id = 1370 },
	{ choice = "the.Endless.Nightmare",  	 	id = 1371 },
	{ choice = "the.Sundering.Slash",      		id = 1372 },
	{ choice = "Entwined.Serpents", 	 	id = 1373 },
	{ choice = "the.Horned.Beast",        	 	id = 1374 },
	{ choice = "Aquatic.Ardor",     	 	id = 1375 },
        { choice = "the.Fallen.One", 	 		id = 1376 },
	{ choice = "Fires.and.Flares",     	 	id = 1377 }
}

local vp = player:getCurrency("valor_point")
local token = player:getCharVar("atma_token")
local cost = 25000

        for _, v in pairs(AtmaData) do
		if v.choice == Choice then
			if (player:hasKeyItem(v.id)) then
				player:PrintToPlayer(string.format("Atma.of.%s already obtained.", v.choice), 29)
				return
			elseif (token > 0) then
				player:addKeyItem(v.id)
				player:setCharVar("atma_token", token - 1)
				player:PrintToPlayer(string.format("Atma Tokens Remaining: %u", player:getCharVar("atma_token")), 29)
    				player:messageSpecial(ID.text.KEYITEM_OBTAINED, v.id)
				return
			elseif (vp < cost) then
				player:PrintToPlayer(string.format("Not enough Valor Points to obtain the selected atma."), 14)
				player:PrintToPlayer(string.format("Required: %i | Player Amount: %i", cost, vp), 14)
				return
			else
				player:addKeyItem(v.id)
				player:delCurrency("valor_point", cost)
				player:PrintToPlayer(string.format("Valor Points Remaining: %u", player:getCurrency("valor_point")), 29)
    				player:messageSpecial(ID.text.KEYITEM_OBTAINED, v.id)
			end
                end
        end

        if Choice == "Next>" then
                player:PrintToPlayer(string.format("Atma.of? %s %s %s %s %s <Back",opt8, opt9, opt10, opt11, opt12), 12)
	end

        if Choice == "<Back" then
		player:PrintToPlayer(string.format("Atma.of? %s %s %s %s %s %s %s Next>",opt1, opt2, opt3, opt4, opt5, opt6, opt7), 12)
	end

        if Choice == "Canceled." then
		player:PrintToPlayer(string.format("Selection cancelled."), 29)
	end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end