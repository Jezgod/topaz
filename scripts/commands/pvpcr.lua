---------------------------------------------------------------------------------------------------
-- func: pvpcr
-- desc: Prints the current status of the cruor bonus ratio
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
};

function onTrigger(player)
	local sandy = player:getCruorRatio(0)
 	local basty = player:getCruorRatio(1)
	local windy = player:getCruorRatio(2)

	player:PrintToPlayer(string.format("Current state of global PVP Cruor bonus is: San d'Oria %u%% / Bastok %u%% / Windurst %u%%",sandy, basty, windy), 29)
end