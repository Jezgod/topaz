-----------------------------------
-- Zone: Abyssea - Altepa
--  NPC: Atma Fabricant
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Abyssea-Altepa/IDs")
-----------------------------------

local opt1  = "the.Merciless.Matriarch"
local opt2  = "the.Brother.Wolf"
local opt3  = "the.Earth.Wyrm"
local opt4  = "the.Ascending.One"    
local opt5  = "the.Scorpion.Queen"    
local opt6  = "a.Thousand.Needles"
local opt7  = "the.Burning.Effigy"   
local opt8  = "the.Smiting.Blow"   
local opt9  = "the.Lone.Wolf"   
local opt10 = "the.Crimson.Scale"
local opt11 = "the.Scarlet.Wing"
local opt12 = "the.Raised.Tail"
local opt13 = "the.Sand.Emperor"   

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
	{ choice = "the.Merciless.Matriarch",        	id = 1339 },
	{ choice = "the.Brother.Wolf",          	id = 1340 },
	{ choice = "the.Earth.Wyrm",    		id = 1341 },
	{ choice = "the.Ascending.One",    	 	id = 1342 },
	{ choice = "the.Scorpion.Queen",  	 	id = 1343 },
	{ choice = "a.Thousand.Needles",  	 	id = 1344 },
	{ choice = "the.Burning.Effigy",         	id = 1345 },
	{ choice = "the.Smiting.Blow", 	 		id = 1346 },
	{ choice = "the.Lone.Wolf",        	 	id = 1347 },
	{ choice = "the.Crimson.Scale",     	 	id = 1348 },
        { choice = "the.Scarlet.Wing", 	 		id = 1349 },
	{ choice = "the.Raised.Tail",        	 	id = 1350 },
	{ choice = "the.Sand.Emperor",     	 	id = 1351 }
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
                player:PrintToPlayer(string.format("Atma.of? %s %s %s %s %s %s <Back",opt8, opt9, opt10, opt11, opt12, opt13), 12)
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