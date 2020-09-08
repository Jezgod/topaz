---------------------------------------------------------------------------------------------------
-- func: pvpi
-- desc: Prints the current status of the imperial standing bonus ratio
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
};

function onTrigger(player)
	local sandy = player:getImperialPointRatio(0)
 	local basty = player:getImperialPointRatio(1)
	local windy = player:getImperialPointRatio(2)

	player:PrintToPlayer(string.format("Current state of global PVP Imperial Standing bonus is: San d'Oria %u%% / Bastok %u%% / Windurst %u%%",sandy, basty, windy), 29) 
    
end