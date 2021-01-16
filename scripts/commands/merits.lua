---------------------------------------------------------------------------------------------------
-- func: !merits
-- desc: Prints the Stored Merits of the player
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
};

function onTrigger(player)
    local storedmerits = player:getCharVar("[store]Merits")
   
    player:PrintToPlayer(string.format("%s's Stored Merit total: %u ", player:getName(), storedmerits), 29);

end;
