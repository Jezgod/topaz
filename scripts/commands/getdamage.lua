---------------------------------------------------------------------------------------------------
-- func: getName
-- desc: Prints the nation of the currently selected target under the cursor
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
};

function onTrigger(player)
      local targ = player
    --local targ = player:getCursorTarget();
    --if (targ ~= nil) then
        player:PrintToPlayer(string.format("Main Slot Weapon Damage: %s", targ:getWeaponDmg()), 29);
    --else
        --player:PrintToPlayer("Must select a target using in game cursor first.");
    --end
end;
