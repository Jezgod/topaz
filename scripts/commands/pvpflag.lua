---------------------------------------------------------------------------------------------------
-- func: pvpflag
-- desc: enables PVP flag in an eligible zone
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
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
    	252, -- Norg
	256, -- Western Adoulin
	257, -- Eastern Adoulin
}

local function validZone(zone_list, id)
	for k,v in pairs(zone_list) do
		if v == id then
		return true
 		end
 	end
end

function onTrigger(player)
	zone = player:getZoneID()
        pvp = player:getCharVar("pvp_flag")
	local nationByNum = {
		[0] = "None",
        	[1] = "Player",
        	[2] = "San d'Oria",
        	[3] = "Bastok",
        	[4] = "Windurst"
    	}
	
        -- set player status
	nation = player:getNation()
    	allegiance = 0
	--player:setCharVar("lootvar", 0)
	
	if validZone(zone_list, zone) == true then
		player:PrintToPlayer( string.format("This function is not valid in the current zone."), 14)
        elseif (pvp == 1) then
                player:PrintToPlayer( string.format("PVP already enabled."), 29 )
                return 1
    	else
		--player:getCharVar("lootvar") == 0 then
		allegiance = nation + 2
     		player:setAllegiance( allegiance )
		--player:lockstyleOn()
		player:PrintToPlayer( string.format("*** PVP Flag Enabled ***"),29 )
		player:PrintToPlayer( string.format("Allegiance set to %s", nationByNum[allegiance]), 29 )
		player:setAnimation(33)
		player:timer(5000, function(player)
		player:setAnimation(0)
		end)

		if (player:hasPet()) then
		    player:despawnPet()
		else
		end

		player:setCharVar("pvp_flag", 1)
   	end	
end