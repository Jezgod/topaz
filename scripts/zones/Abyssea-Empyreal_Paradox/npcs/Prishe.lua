-----------------------------------
-- Zone: Empyreal Paradox
--  NPC: Atma Infusionist
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
-----------------------------------

local opt1  = "the.Hateful.Stream"
local opt2  = "the.Apocalypse"   

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    --player:startEvent(2182)
    player:SetEventNPC(npc:getID())

    player:PrintToPlayer(string.format("Atma.of? %s %s",opt1, opt2), 12)
end

function onMenuSelection(player, npc, Choice)
local AtmaData = 
{
	{ choice = "the.Hateful.Stream",  	 id = 1369,	cost = 25000,	token = 1 },
	{ choice = "the.Apocalypse",             id = 1378,	cost = 50000, 	token = 2}
}

local vp = player:getCurrency("valor_point")
local token = player:getCharVar("atma_token")
local currency = player:getLocalVar("atma_method")

        for _, v in pairs(AtmaData) do
		if v.choice == Choice then
			if (player:hasKeyItem(v.id)) then
				player:PrintToPlayer(string.format("Atma.of.%s already obtained.", v.choice), 29)
				return
 			elseif (currency == 1) then
			        if (token >= v.token) then
				    player:addKeyItem(v.id)
				    player:setCharVar("atma_token", token - v.token)
				    player:PrintToPlayer(string.format("Atma Tokens Remaining: %u", player:getCharVar("atma_token")), 29)
    				    player:messageSpecial(ID.text.KEYITEM_OBTAINED, v.id)
				    return
				else
				   player:PrintToPlayer(string.format("Not enough Atma Tokens to obtain the selected atma."), 14)
				   player:PrintToPlayer(string.format("Required: %i | Player Amount: %i", v.token, token), 14)
				   return
				end
			elseif (currency == 2) then
				if (vp < v.cost) then
				    player:PrintToPlayer(string.format("Not enough Valor Points to obtain the selected atma."), 14)
				    player:PrintToPlayer(string.format("Required: %i | Player Amount: %i", v.cost, vp), 14)
				    return
			        else
				    player:addKeyItem(v.id)
				    player:delCurrency("valor_point", v.cost)
				    player:PrintToPlayer(string.format("Valor Points Remaining: %u", player:getCurrency("valor_point")), 29)
    				    player:messageSpecial(ID.text.KEYITEM_OBTAINED, v.id)
				end
			else
				player:PrintToPlayer(string.format("Please choose method to obtain the atma from the Atma Infusionist."), 29)
			end
                end
        end

        if Choice == "Canceled." then
		player:PrintToPlayer(string.format("Selection cancelled."), 29)
	end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end