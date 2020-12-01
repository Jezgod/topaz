-----------------------------------
-- Zone: Abyssea - Misareaux
--  NPC: Atma Fabricant
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Abyssea-Misareaux/IDs");
-----------------------------------

local opt1  = "the.Gnarled.Horn"
local opt2  = "the.Strangling.Wind"
local opt3  = "the.Deep.Devourer"
local opt4  = "the.Mounted.Champion"    
local opt5  = "the.Razed.Ruins"    
local opt6  = "the.Bludgeoning.Brute"
local opt7  = "the.Rapid.Reptilian"   
local opt8  = "the.Winged.Enigma"   
local opt9  = "the.Cradle"   
local opt10 = "the.Untouched"   

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
	{ choice = "the.Gnarled.Horn",       	 id = 1319 },
	{ choice = "the.Strangling.Wind",        id = 1320 },
	{ choice = "the.Deep.Devourer",        	 id = 1321 },
	{ choice = "the.Mounted.Champion",    	 id = 1322 },
	{ choice = "the.Razed.Ruins",  		 id = 1323 },
	{ choice = "the.Bludgeoning.Brute",      id = 1324 },
	{ choice = "the.Rapid.Reptilian",      	 id = 1325 },
	{ choice = "the.Winged.Enigma", 	 id = 1326 },
	{ choice = "the.Cradle",        	 id = 1327 },
	{ choice = "the.Untouched",     	 id = 1328 }
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