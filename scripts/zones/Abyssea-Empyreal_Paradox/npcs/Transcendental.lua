-----------------------------------
-- Area: Quifm_Island
-- NPC:  Transcendental
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/missions");
require("scripts/globals/keyitems");
require("scripts/globals/bcnm");

function onTrade(player,npc,trade)

end;

function onTrigger(player,npc)
	local x1 = -258;
    	local y1 = -21;
    	local z1 = 222;
    	local rot1 = 85;
	local zone = 126; 
        local pLevel = player:getMainLvl()
        
        if (pLevel == 75) then
       	    player:setPos(x1, y1, z1, rot1, zone);
        else
      	    player:PrintToPlayer( string.format("You are not strong enough to enter this portal..."),29)
        end
end;

function onEventUpdate(player,csid,option,extras)
end;

function onEventFinish(player,csid,option)
end;
