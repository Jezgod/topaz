-----------------------------------
-- Area: Port Jeuno
--  NPC: Shemo
-- Orb Trader (BCNM)
-- !pos -14 8 44 246
-----------------------------------
require("scripts/globals/settings");
require("scripts/globals/quests");
local ID = require("scripts/zones/Port_Jeuno/IDs");
-----------------------------------

local opt1  = "Up"
local opt2  = "Down"

function onTrade(player,npc,trade)
    local NumberItem = trade:getItemCount();
    local Item = math.floor(NumberItem / 3)
    local bythree = NumberItem % 3
    local timesthree = NumberItem * 3
    local BeastmensSeal = player:getSeals(0);
    local KindredsSeal = player:getSeals(1);
    local KindredsCrest = player:getSeals(2);
    local HighKindredsCrest = player:getSeals(3);
    local SacredKindredsCrest = player:getSeals(4);
    local Choice = player:getLocalVar("seal_conversion")
----------------------------------------------------------------------------------------------------------------------------
-------- Trading Seals/Crests to Shemo -------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
    
    if (Choice == 1) then
        if (bythree ~= 0) then
	    player:PrintToPlayer( string.format("Please trade is quantities of three"), 29 )
	    return 1;
        end
	
        if (trade:hasItemQty(1126,NumberItem) and trade:getItemCount() == NumberItem) then
            player:tradeComplete();
	    player:addItem(1127,Item);
            player:messageSpecial(ID.text.ITEM_OBTAINED,1127);
            printf("item : %u",Item)
        elseif (trade:hasItemQty(1127,NumberItem) and trade:getItemCount() == NumberItem) then
            player:tradeComplete();
	    player:addItem(2955,Item);
            player:messageSpecial(ID.text.ITEM_OBTAINED,2955);
            printf("item : %u",Item)
        elseif (trade:hasItemQty(2955,NumberItem) and trade:getItemCount() == NumberItem) then
            player:tradeComplete();
	    player:addItem(2956,Item);
            player:messageSpecial(ID.text.ITEM_OBTAINED,2956);
            printf("item : %u",Item)
        elseif (trade:hasItemQty(2956,NumberItem) and trade:getItemCount() == NumberItem) then
            player:tradeComplete();
	    player:addItem(2957,Item);
            player:messageSpecial(ID.text.ITEM_OBTAINED,2957);
            printf("item : %u",Item)
        else
            player:PrintToPlayer( string.format("Not a valid trade.  Please try again."), 29 )
        end

     elseif (Choice == 2) then
	if (trade:hasItemQty(2957,NumberItem) and trade:getItemCount() == NumberItem) then
            player:tradeComplete();
	    player:addItem(2956,timesthree);
            player:messageSpecial(ID.text.ITEM_OBTAINED,2956);
            printf("item : %u",Item)
        elseif (trade:hasItemQty(2956,NumberItem) and trade:getItemCount() == NumberItem) then
            player:tradeComplete();
	    player:addItem(2955,timesthree);
            player:messageSpecial(ID.text.ITEM_OBTAINED,2955);
            printf("item : %u",Item)
        elseif (trade:hasItemQty(2955,NumberItem) and trade:getItemCount() == NumberItem) then
            player:tradeComplete();
	    player:addItem(1127,timesthree);
            player:messageSpecial(ID.text.ITEM_OBTAINED,1127);
            printf("item : %u",Item)
        elseif (trade:hasItemQty(1127,NumberItem) and trade:getItemCount() == NumberItem) then
            player:tradeComplete();
	    player:addItem(1126,timesthree);
            player:messageSpecial(ID.text.ITEM_OBTAINED,1126);
            printf("item : %u",Item)
        else
            player:PrintToPlayer( string.format("Not a valid trade.  Please try again."), 29 )
        end
    end
end;

function onTrigger(player,npc)  
    player:SetEventNPC(npc:getID());
    player:PrintToPlayer(string.format("Convert? %s %s",opt1, opt2), 12);
    player:PrintToPlayer( string.format("Choose conversion Up: Trade 3 seals/crests of a lower tier to get 1 higher tier seal/crest"), 29 )
    player:PrintToPlayer( string.format("Choose conversion Down: Trade 1 seal/crest of a higher tier to get 3 lower tier seal/crests"), 29 )
end;

function onMenuSelection(player, npc, Choice)
local data = 
{
	{ choice = "Up",             id = 1,	seal1 = 1126,	seal2 = 1127,	seal3 = 2955, seal4 = 2956 },
	{ choice = "Down",           id = 2, 	seal1 = 2956,	seal2 = 2955,	seal3 = 1127, seal4 = 1126 }
}

	for _, v in pairs(data) do
		if v.choice == Choice then
			if (v.id == 1) then
				player:setLocalVar("seal_conversion",v.id);
				return;
			elseif (v.id == 2) then
				player:setLocalVar("seal_conversion",v.id);
				return;
			else
				player:PrintToPlayer(("Please try again."), 29);
			end
                end
        end
end
	