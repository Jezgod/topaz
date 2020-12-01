-----------------------------------
-- Area: Abyssea-La_Theiene
--  NPC: Atma_Infusionist
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Abyssea-La_Theine/IDs");
-----------------------------------

function onTrade(player,npc,trade)
        local pLevel = player:getMainLvl()
  	local ki1 = tpz.ki.LUNAR_ABYSSITE1
        local name = "Lunar Abbysite"
        local abby1 = player:hasKeyItem(ki1);
        local item = 1126
        local count = 100

	if (abby1) then
	    player:PrintToPlayer( string.format("You already possess the %s this zone provides.", name), 13 )
	elseif (pLevel < 75) then
	    player:PrintToPlayer( string.format("You are not yet strong enough.  Come back once you have achieved Level 75."), 13 )
	elseif (pLevel >= 75 and trade:hasItemQty(item, count)) and
	    trade:getItemCount() == count then
	    player:tradeComplete();
    	    player:addKeyItem(ki1);
            player:messageSpecial(ID.text.KEYITEM_OBTAINED,ki1);
        else
	    player:PrintToPlayer( string.format("Please try trading the appropriate items."), 13 )
    	end
end

function onTrigger(player,npc)
	player:PrintToPlayer( string.format("Trade 100 Beastmen's Seals, at Level 75 or greater, to receive your first Lunar Abyssite."), 13 )
    
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end