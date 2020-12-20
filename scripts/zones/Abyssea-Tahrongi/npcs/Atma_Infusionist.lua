-----------------------------------
-- Area: Abyssea-Attohwa
-- NPC: Atma Infusionist
-- 
-- 
-----------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/Abyssea-Tahrongi/IDs")
-----------------------------------

local opt1  = "Atma.Token"
local opt2  = "Valor.Points"

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    player:SetEventNPC(npc:getID())
    player:PrintToPlayer(string.format("Method? %s %s",opt1, opt2), 12)
    player:PrintToPlayer( string.format("Choose Atma.Token to obtain atma with Atma Token."), 29 )
    player:PrintToPlayer( string.format("Choose Valor.Points to obtain atma with Valor Points."), 29 )
end

function onMenuSelection(player, npc, Choice)
local data = 
{
	{ choice = "Atma.Token",             id = 1 },
	{ choice = "Valor.Points",           id = 2 }
}

	for _, v in pairs(data) do
		if v.choice == Choice then
			if (v.id == 1) then
				player:setLocalVar("atma_method",v.id)
				player:PrintToPlayer( string.format("Atma Token will be used to obtain atma from the Atma Fabricant."), 29 )
				return
			elseif (v.id == 2) then
				player:setLocalVar("atma_method",v.id)
				player:PrintToPlayer( string.format("Valor Points will be used to obtain atma from the Atma Fabricant."), 29 )
				return
			else
				player:PrintToPlayer(("Please try again."), 29)
			end
                end
        end

        if Choice == "Canceled." then
		player:PrintToPlayer(string.format("Selection cancelled."), 29)
	end
end
	