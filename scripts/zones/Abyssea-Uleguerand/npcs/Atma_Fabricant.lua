-----------------------------------
-- Zone: Abyssea - Uleguerand
--  NPC: Atma Fabricant
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Abyssea-Uleguerand/IDs");
-----------------------------------

local opt1  = "the.Omnipotent"
local opt2  = "the.War.Lion"
local opt3  = "the.Frozen.Fetters"
local opt4  = "the.Plaguebringer"    
local opt5  = "the.Shrieking.One"    
local opt6  = "the.Holy.Mountain"
local opt7  = "the.Lake.Lurker"   
local opt8  = "the.Crushing.Cudgel"   
local opt9  = "Purgatory"   
local opt10 = "the.Blighted.Breath"
local opt11 = "the.Persistent.Predator"
local opt12 = "the.Stone.God"
local opt13 = "the.Sun.Eater"   

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    --player:startEvent(2182)
    player:SetEventNPC(npc:getID());

    player:PrintToPlayer(string.format("Atma.of? %s %s %s %s %s %s %s Next>",opt1, opt2, opt3, opt4, opt5, opt6, opt7), 12);
end

function onMenuSelection(player, npc, Choice)
local AtmaData = 
{
	{ choice = "the.Omnipotent",        		id = 1352 },
	{ choice = "the.War.Lion",          		id = 1353 },
	{ choice = "the.Frozen.Fetters",    		id = 1354 },
	{ choice = "the.Plaguebringer",    	 	id = 1355 },
	{ choice = "the.Shrieking.One",  	 	id = 1356 },
	{ choice = "the.Holy.Mountain",  	 	id = 1357 },
	{ choice = "the.Lake.Lurker",         		id = 1358 },
	{ choice = "the.Crushing.Cudgel", 	 	id = 1359 },
	{ choice = "Purgatory",        	 		id = 1360 },
	{ choice = "the.Blighted.Breath",     	 	id = 1361 },
        { choice = "the.Persistent.Predator", 	 	id = 1362 },
	{ choice = "the.Stone.God",        	 	id = 1363 },
	{ choice = "the.Sun.Eater",     	 	id = 1364 }
}

local vp = player:getCurrency("valor_point")
local cost = 25000

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
                player:PrintToPlayer(string.format("Atma.of? %s %s %s %s %s %s <Back",opt8, opt9, opt10, opt11, opt12, opt13), 12);
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