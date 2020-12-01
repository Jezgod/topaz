-----------------------------------
-- Area: Quifm_Island
-- NPC:  Transcendental
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/missions");
require("scripts/globals/keyitems");
require("scripts/globals/bcnm");

-- returns Lunar Abyssites
function getLunarAbyssiteTotal(player, abyssite)
    local LUNAR = 0
    if abyssite == "LUNAR" then
    	for ki = tpz.ki.LUNAR_ABYSSITE1, tpz.ki.LUNAR_ABYSSITE3 do
        	if player:hasKeyItem(ki) then
            		LUNAR = LUNAR + 1
        	end
    	end
        return LUNAR
    end
end;

function onTrade(player,npc,trade)

end;

function onTrigger(player,npc)
	local x1 = 540;
    	local y1 = -500;
    	local z1 = -594;
    	local rot1 = 64;
	local zone = 255; 
        local pLevel = player:getMainLvl()
        local abysstotal = getLunarAbyssiteTotal(player, "LUNAR")
        
        if (pLevel >= 75 and abysstotal == 3) then
       	    player:setPos(x1, y1, z1, rot1, zone);
        else
      	    player:PrintToPlayer( string.format("You are not strong enough to enter this portal..."),31)
        end
end;

function onEventUpdate(player,csid,option,extras)
end;

function onEventFinish(player,csid,option)
end;
