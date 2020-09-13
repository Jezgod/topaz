---------------------------------------------------------------------------------------------------
-- func: pvpb
-- desc: Prints the current status of the bayld bonus ratio
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
};

function onTrigger(player)
	local sandy = player:getBayldRatio(0)
 	local basty = player:getBayldRatio(1)
	local windy = player:getBayldRatio(2)

	player:PrintToPlayer(string.format("Current state of global PVP Bayld bonus is: San d'Oria %u%% / Bastok %u%% / Windurst %u%%",sandy, basty, windy), 29)
end