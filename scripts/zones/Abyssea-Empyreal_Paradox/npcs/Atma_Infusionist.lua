-----------------------------------
-- Zone: Empyreal Paradox
--  NPC: Atma Infusionist
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Empyreal_Paradox/IDs");
-----------------------------------

local opt1  = "the.Apocalypse"   

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    --player:startEvent(2182)
    player:SetEventNPC(npc:getID());

    player:PrintToPlayer(string.format("Atma.of? %s",opt1), 12);
end

function onMenuSelection(player, npc, Choice)
local AtmaData = 
{
	{ choice = "the.Apocalypse",             id = 1378 }
}

local vp = player:getCurrency("valor_point")
local cost = 50000

        for _, v in pairs(AtmaData) do
		if v.choice == Choice then
			if (player:hasKeyItem(v.id)) then
				player:PrintToPlayer(string.format("Atma.of.%s already obtained.", v.choice), 29);
				return;
			elseif (vp < cost) then
				player:PrintToPlayer(string.format("Not enough Valor Points to obtain the atma."), 29);
				player:PrintToPlayer(string.format("Required: %i, Player Amount: %i", cost, vp), 29);
				return;
			else
				player:addKeyItem(v.id);
				player:delCurrency("valor_point", cost);
    				player:messageSpecial(ID.text.KEYITEM_OBTAINED, v.id);
			end
                end
        end

        if Choice == "Next>" then
                player:PrintToPlayer(string.format("Atma.of? %s %s %s <Back",opt8, opt9, opt10), 12);
	end

        if Choice == "<Back" then
		player:PrintToPlayer(string.format("Atma.of? %s %s %s %s %s %s %s Next>",opt1, opt2, opt3, opt4, opt5, opt6, opt7), 12);
	end

        if Choice == "Canceled." then
		player:PrintToPlayer(string.format("Selection cancelled."), 29);
	end
end;

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end