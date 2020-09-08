---------------------------------------------------------------------------------------------------
-- func: setallegiance
-- desc: Sets the target players allegiance.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "ss"
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!setallegiance {player} <nation>");
    player:PrintToPlayer("Nations: 0=None 2=San d'Oria 3=Bastok 4=Windurst");
end;

function onTrigger(player, arg1, arg2)
    local targ;
    local nation;
    
    -- validate target
    if (arg2 ~= nil) then
        targ = GetPlayerByName(arg1);
        if (targ == nil) then
            error(player, string.format( "Player named '%s' not found!", arg1 ));
            return;
        end
        nation = tonumber(arg2);
    elseif (arg1 ~= nil) then
        targ = player;
        nation = tonumber(arg1);
    end

    -- validate nation
    if (nation == nil or nation < 1 or nation > 4) then
        error(player, "Invalid nation ID.");
        return;
    end

    local nationByNum = {
	[0] = "None",
        [1] = "Player",
        [2] = "San d'Oria",
        [3] = "Bastok",
        [4] = "Windurst"
    }

    -- set nation
    targ:setAllegiance( nation );
    player:PrintToPlayer( string.format("Set %s's allegiance to %s.", targ:getName(), nationByNum[nation]) );
end;