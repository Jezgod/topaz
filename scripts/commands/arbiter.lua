---------------------------------------------------------------------------------------------------
-- func: arbiter
-- desc: Goes to the target player and initiates a PVP encounter
---------------------------------------------------------------------------------------------------

local zone_list =
{
	26,  -- Tavnazian Safehold
	48,  -- Al Zahbi
	50,  -- Aht Urhgan Whitegate
        53,  -- Nashmau
        71,  -- The Colosseum
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

local function validZone(zone_list, id)
	for k,v in pairs(zone_list) do
		if v == id then
		return true
 		end
 	end
end

cmdprops =
{
    permission = 0,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!arbiter <player>")
end

function onTrigger(player, target)
   local pLevel = player:getMainLvl()
   local pNation = player:getNation()
   local infamy = player:getCurrency("infamy")
   local arbiter_cost = 100
   local zone
   local nation
   local t_alleg
   local t_cooldown
   local p_cooldown

    -- validate target
    if not target then
        error(player, "You must enter a player name.")
        return
    end

    local targ = GetPlayerByName(target)

    if targ ~= nil then
        zone = targ:getZoneID()
        nation = targ:getNation()
        t_alleg = nation + 2
        t_cooldown = targ:getCharVar("arbiter_t")
        p_cooldown = targ:getCharVar("arbiter_p")
    end

    if validZone(zone_list, zone) == true then
	player:PrintToPlayer( string.format("Target cannot be arbitered due to location"), 14)
        return 1
    elseif (infamy < arbiter_cost ) then
        player:PrintToPlayer( string.format("Target cannot be arbitered due to lack of infamy"), 14)
        return 1
    elseif (t_cooldown > os.time()) then
        player:PrintToPlayer( string.format("Target cannot be arbitered at the current time"), 14)
        return 1
    elseif (p_cooldown > os.time()) then
        player:PrintToPlayer( string.format("Target cannot be arbitered at the current time"), 14)
        return 1
    elseif (targ:isEngaged()) then
        player:PrintToPlayer( string.format("Target cannot be engaged in battle"), 14)
        return 1
    elseif (pNation == targ:getNation()) then
        player:PrintToPlayer( string.format("Target must be from a different nation"), 14)
        return 1
    elseif (targ:isDead()) then
        player:PrintToPlayer( string.format("Target cannot be dead"), 14)
        return 1
    elseif (pLevel < 90) then
        player:PrintToPlayer( string.format("Level 90 is minimum level to arbiter"), 14)
        return 1
    elseif (targ:getMainLvl() < pLevel) then
        player:PrintToPlayer( string.format("Only an equal or higher level target can be arbitered"), 14)
        return 1
    elseif targ then
        player:setPos(targ:getXPos() + math.random(1,5), targ:getYPos(), targ:getZPos() + math.random(1,5), targ:getRotPos() + math.random(1,180), targ:getZoneID())
	targ:PrintToPlayer( string.format("An arbiter player has appeared..."), 29)
        targ:setAllegiance( t_alleg )
        targ:setAnimation(33)
        targ:timer(12000, function(player)
		targ:setAnimation(0)
		end)
	targ:setCharVar("arbiter_t" ,os.time() + 3600)
        player:setCharVar("arbiter_p" ,os.time() + 120)
        player:delCurrency("infamy", arbiter_cost)
        targ:setCharVar("pvp_flag", 1)

    elseif not player:gotoPlayer(target) then
        error(player, string.format("Player named: %s not found!"), target)
    end
end
