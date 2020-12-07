-----------------------------------
-- Area: Abyssea-Konschtat
--  NPC: Atma_Infusionist
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Abyssea-Konschtat/IDs");
-----------------------------------

function onTrade(player,npc,trade)
        local pLevel = player:getMainLvl()
  	local ki1 = tpz.ki.LUNAR_ABYSSITE1
        local ki2 = tpz.ki.LUNAR_ABYSSITE2
        local name = "Lunar Abbysite"
        local abby1 = player:hasKeyItem(ki1);
        local abby2 = player:hasKeyItem(ki2);
        local item = 1127
        local count = 100

	if (abby2) then
	    player:PrintToPlayer( string.format("You already possess the %s this zone provides.", name), 13 )
        elseif not (abby1) then
	    player:PrintToPlayer( string.format("You require the first Lunar Abbysite from Abyssea - La Theine.", name), 13 )
	elseif (pLevel < 75) then
	    player:PrintToPlayer( string.format("You are not yet strong enough.  Come back once you have achieved Level 75."), 13 )
	elseif (pLevel >= 75 and trade:hasItemQty(item, count)) and abby1 and
	    trade:getItemCount() == count then
	    player:tradeComplete();
    	    player:addKeyItem(ki2);
            player:messageSpecial(ID.text.KEYITEM_OBTAINED,ki2);
        else
	    player:PrintToPlayer( string.format("Please try trading the appropriate items."), 13 )
    	end
end

function onTrigger(player,npc)
	player:PrintToPlayer( string.format("Trade 100 Kindred Seals, at Level 75 or greater, to receive your second Lunar Abyssite."), 13 )
    
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end