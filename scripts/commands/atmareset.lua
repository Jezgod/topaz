---------------------------------------------------------------------------------------------------
-- func: atmareset
-- desc: Resets player's atma
---------------------------------------------------------------------------------------------------

require("scripts/globals/status");

cmdprops =
{
    permission = 0,
    parameters = ""
};

function onTrigger(player)
    local targ = player;
    local time = os.time()
    local effect = tpz.effect.ATMA
    
    if (targ:getLocalVar("atma_cooldown") < time) then
    	targ:setCharVar("infused_atma", 0);
    	while (targ:hasStatusEffect(effect)) do
    	    targ:delStatusEffect(effect);
    	end

        targ:setLocalVar("last_atma", 0)
        targ:setLocalVar("atma_1", 0)
        targ:setLocalVar("atma_2", 0)
	targ:setLocalVar("atma_3", 0)
	targ:setLocalVar("atma_4", 0)
        targ:PrintToPlayer( string.format( "Atma has been successfully reset." ), 29);
    else
	targ:PrintToPlayer( string.format( "You must wait longer to use that command." ));
    end

end;
