---------------------------------------------------------------------------------------------------
-- func: !anchor [<set> <go> <where> <clear>]
-- desc: Used to warp to a predfined destination
---------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------
require("scripts/globals/status");
-------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = "ss"
}

local zone_list =
{
	26,  -- Tavnazian Safehold 
        32,  -- Sealion's Den
	48,  -- Al Zahbi
	50,  -- Aht Urhgan Whitegate
        53,  -- Nashmau
        80,  -- Southern San d'Oria [S]
        87,  -- Bastok Markets [S]
        94,  -- Windurst Waters [S]
	230, -- Southern San d'Oria
    	231, -- Northern San d'Oria
    	232, -- Port San d'Oria
    	233, -- Chateau d'Oraguille
	234, -- Bastok Mines
	235, -- Bastok Markets
	236, -- Port Bastok
	237, -- Metalworks
	238, -- Windurst Waters
    	239, -- Windurst Walls
    	240, -- Port Windurst
    	241, -- Windurst Woods
    	242, -- Heavens Tower
    	243, -- Ru'Lude Gardens
    	244, -- Upper Jeuno
    	245, -- Lower Jeuno
    	246, -- Port Jeuno
    	247, -- Rabao
    	248, -- Selbina
    	249, -- Mhaura
    	250, -- Kazham
    	251, -- Hall of the Gods
    	252  -- Norg
}

local zone_list_deny_set =
{
	71,  -- The Colosseum 

}

local function validZone(zone_list, id)
	for k,v in pairs(zone_list) do
		if v == id then
		return true
 		end
 	end
end

local function denyZone(zone_list_deny_set, id)
	for k,v in pairs(zone_list_deny_set) do
		if v == id then
		return true
 		end
 	end
end

function onTrigger(PC, Command, Sub)

    Command = Command or nil
    Sub = Sub or nil

    if not Command then
        PC:PrintToPlayer("Instructions", 29)
        PC:PrintToPlayer("!anchor help: Provides help with anchor system.", 29)
        return
    end
    
    Command = string.lower(Command)

    if Command == "help" then
        PC:PrintToPlayer("The sub-commands available for !anchor are as follows:", 29)
        PC:PrintToPlayer("!anchor set: Sets current location as anchor point.", 29)
        PC:PrintToPlayer("!anchor go: Send player to anchor point from safe areas.", 29)
        PC:PrintToPlayer("!anchor where: Displays current anchor point.", 29)
        PC:PrintToPlayer("!anchor clear: Clears current anchor point.", 29)

    elseif Command == "set" then
      	local pos = PC:getPos()
	local zone = PC:getZoneID()

	if denyZone(zone_list_deny_set, zone) == true then
		PC:PrintToPlayer( string.format("This function is not valid in the current zone"), 14 )
	else
        	PC:setCharVar("anchor_x",pos.x)
		PC:setCharVar("anchor_y",pos.y)
		PC:setCharVar("anchor_z",pos.z)
		PC:setCharVar("anchor_rot",pos.rot)
		PC:setCharVar("anchor_zone",zone)        
        	PC:PrintToPlayer("Anchor point set.", 29)
	end

    elseif Command == "go" then
 	local x = PC:getCharVar("anchor_x")
    	local y = PC:getCharVar("anchor_y")
    	local z = PC:getCharVar("anchor_z")
    	local rot = PC:getCharVar("anchor_rot")
    	local zone = PC:getCharVar("anchor_zone")
	local pzone = PC:getZoneID()

	if validZone(zone_list, pzone) == true then
		PC:PrintToPlayer( string.format("Sending %s to zone %i.", PC:getName(), zone) )
        	PC:setAnimation(33)
 		PC:timer(10000, function(PC)
			PC:setPos(x, y, z, rot, zone)
			end)
		
	elseif (zone == 0) then
		PC:PrintToPlayer( string.format("No anchor point set"), 14 )
	else
		PC:PrintToPlayer( string.format("This function is not valid in the current zone"), 14 )
	end

    elseif Command == "where" then
        local x = PC:getCharVar("anchor_x")
    	local y = PC:getCharVar("anchor_y")
    	local z = PC:getCharVar("anchor_z")
    	local rot = PC:getCharVar("anchor_rot")
    	local zone = PC:getCharVar("anchor_zone")

	PC:PrintToPlayer( string.format("x: %i y:%i, z: %i, rot: %i, zone: %i", x, y, z, rot, zone), 29 )

    elseif Command == "clear" then

        PC:setCharVar("anchor_x",0)
	PC:setCharVar("anchor_y",0)
	PC:setCharVar("anchor_z",0)
	PC:setCharVar("anchor_rot",0)
	PC:setCharVar("anchor_zone",0)        
        PC:PrintToPlayer("Anchor point cleared.", 29)
    end
end
