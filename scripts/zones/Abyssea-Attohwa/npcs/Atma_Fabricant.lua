-----------------------------------
-- Zone: Abyssea - Attowha
--  NPC: Atma Fabricant
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Abyssea-Attohwa/IDs")
-----------------------------------

local opt1  = "the.Clawed.Butterfly"
local opt2  = "the.Desert.Worm"
local opt3  = "the.Undying"
local opt4  = "the.Impregnable.Tower"    
local opt5  = "the.Smoldering.Sky"    
local opt6  = "the.Demonic.Skewer"
local opt7  = "the.Golden.Claw"   
local opt8  = "the.Glutinous.Ooze"   
local opt9  = "the.Lightning.Beast"   
local opt10 = "the.Noxious.Bloom"   

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
	{ choice = "the.Clawed.Butterfly",       id = 1309 },
	{ choice = "the.Desert.Worm",        	 id = 1310 },
	{ choice = "the.Undying",        	 id = 1311 },
	{ choice = "the.Impregnable.Tower",    	 id = 1312 },
	{ choice = "the.Smoldering.Sky",  	 id = 1313 },
	{ choice = "the.Demonic.Skewer",         id = 1314 },
	{ choice = "the.Golden.Claw",      	 id = 1315 },
	{ choice = "the.Glutinous.Ooze", 	 id = 1316 },
	{ choice = "the.Lightning.Beast",        id = 1317 },
	{ choice = "the.Noxious.Bloom",     	 id = 1318 }
}

local vp = player:getCurrency("valor_point")
local token = player:getCharVar("atma_token")
local cost = 25000
local token_cost = 1
local currency = player:getLocalVar("atma_method")

        for _, v in pairs(AtmaData) do
		if v.choice == Choice then
			if (player:hasKeyItem(v.id)) then
				player:PrintToPlayer(string.format("Atma.of.%s already obtained.", v.choice), 29)
				return
 			elseif (currency == 1) then
			        if (token > 0) then
				    player:addKeyItem(v.id)
				    player:setCharVar("atma_token", token - 1)
				    player:PrintToPlayer(string.format("Atma Tokens Remaining: %u", player:getCharVar("atma_token")), 29)
    				    player:messageSpecial(ID.text.KEYITEM_OBTAINED, v.id)
				    return
				else
				   player:PrintToPlayer(string.format("Not enough Atma Tokens to obtain the selected atma."), 14)
				   player:PrintToPlayer(string.format("Required: %i | Player Amount: %i", token_cost, token), 14)
				   return
				end
			elseif (currency == 2) then
				if (vp < cost) then
				    player:PrintToPlayer(string.format("Not enough Valor Points to obtain the selected atma."), 14)
				    player:PrintToPlayer(string.format("Required: %i | Player Amount: %i", cost, vp), 14)
				    return
			        else
				    player:addKeyItem(v.id)
				    player:delCurrency("valor_point", cost)
				    player:PrintToPlayer(string.format("Valor Points Remaining: %u", player:getCurrency("valor_point")), 29)
    				    player:messageSpecial(ID.text.KEYITEM_OBTAINED, v.id)
				end
			else
				player:PrintToPlayer(string.format("Please choose method to obtain the atma from the Atma Infusionist."), 29)
			end
                end
        end

        if Choice == "Next>" then
                player:PrintToPlayer(string.format("Atma.of? %s %s %s <Back",opt8, opt9, opt10), 12)
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