-----------------------------------
-- Area: Abyssea - Tahrongi
--  NPC: Atma_Infusionist
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Abyssea-Tahrongi/IDs");
-----------------------------------

function onTrade(player,npc,trade)
        local pLevel = player:getMainLvl()
  	local ki1 = tpz.ki.LUNAR_ABYSSITE1
        local ki2 = tpz.ki.LUNAR_ABYSSITE2
        local ki3 = tpz.ki.LUNAR_ABYSSITE3
        local name = "Lunar Abbysite"
        local abby1 = player:hasKeyItem(ki1);
        local abby2 = player:hasKeyItem(ki2);
        local abby3 = player:hasKeyItem(ki3);
        local item = 2955
        local count = 100

	if (abby3) then
	    player:PrintToPlayer( string.format("You already possess the %s this zone provides.", name), 13 )
        elseif not (abby2) then
	    player:PrintToPlayer( string.format("You require the second Lunar Abbysite from Abyssea - Konschtat."), 13 )
        elseif not (abby1) then
	    player:PrintToPlayer( string.format("You require the first Lunar Abbysite from Abyssea - La Theine."), 13 )
	elseif (pLevel ~= 75) then
	    player:PrintToPlayer( string.format("You are not yet strong enough.  Come back once you have achieved Level 75."), 13 )
	elseif (pLevel == 75 and trade:hasItemQty(item, count) and 
		abby1 and abby2 and
	    	trade:getItemCount() == count) then
	    	player:tradeComplete();
    	    	player:addKeyItem(ki3);
            	player:messageSpecial(ID.text.KEYITEM_OBTAINED,ki3);
        else
	    player:PrintToPlayer( string.format("Please try trading the appropriate items."), 13 )
    	end
end

function onTrigger(player,npc)
	player:PrintToPlayer( string.format("Trade 100 Kindred's Crests, at Level 75, to receive your third Lunar Abyssite."), 13 )
    
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end