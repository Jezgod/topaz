---------------------------------------------------------------------------------------------------
-- func: !bayld
-- desc: Prints the bayld of the player
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
};

function onTrigger(player)
    local currency = "bayld"
    local tAN = player:getCurrency(currency)
   
    player:PrintToPlayer(string.format("%s's Bayld total: %u ", player:getName(),tAN), 29);

end;
