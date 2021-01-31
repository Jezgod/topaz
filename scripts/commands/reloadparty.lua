---------------------------------------------------------------------------------------------------
-- func: reloadparty
-- desc: Reload party
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}


function onTrigger(player)
	player:reloadParty()
        player:PrintToPlayer( string.format( "Leader ID: %i", player:getLeaderID() ) )
        player:PrintToPlayer( string.format( "SoloPartyAlliance: %i", player:checkSoloPartyAlliance() ) )


end