---------------------------------------------------------------------------------------------------
-- func: !infamy
-- desc: Prints the Infamy of the player
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
};

function onTrigger(player)
    local currency = "infamy"
    local tCurrency = player:getCurrency(currency)
   
    player:PrintToPlayer(string.format("%s's Infamy total: %u ", player:getName(),tCurrency), 29);

end;
