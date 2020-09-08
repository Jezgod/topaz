---------------------------------------------------------------------------------------------------
-- func: pvpc
-- desc: Prints the current status of the conquest point bonus ratio
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
};

function onTrigger(player)
	local sandy = player:getConquestPointRatio(0)
 	local basty = player:getConquestPointRatio(1)
	local windy = player:getConquestPointRatio(2)

	player:PrintToPlayer(string.format("Current state of global PVP Conquest Point bonus is: San d'Oria %u%% / Bastok %u%% / Windurst %u%%",sandy, basty, windy), 29)
end