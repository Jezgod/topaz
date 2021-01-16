---------------------------------------------------------------------------------------------------
-- func: checkpvpc <targ>
-- desc: checks player variable and returns result value.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = "ss"
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!checkpvpc {player}");
end;

function onTrigger(player, arg1)
    local targ;
    local varName = "conquestpvppoints";
    
    targ = arg1;

    -- validate target
    if (targ == nil) then
        targ = player:getCursorTarget();
        if (targ == nil or not targ:isPC()) then
            targ = player;
        end
    
    else
        local target = targ;
        targ = GetPlayerByName(targ);
        if (targ == nil) then
            error(player, string.format("Player named '%s' not found!", target));
            return;
        end
    end

    -- show variable
    if (targ == player) then
	player:PrintToPlayer(string.format("%s's total PvP Conquest Points : %u", player:getName(), player:getCharVar(varName)), 29);
    else
    	player:PrintToPlayer(string.format("%s's total PvP Conquest Points : %u", targ:getName(), targ:getCharVar(varName)), 29);
    	player:PrintToPlayer(string.format("%s's total PvP Conquest Points : %u", player:getName(), player:getCharVar(varName)), 29);    
    end

end