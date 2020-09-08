------------------------------------------------------------------------------------------
--  Command: Register
--  Details: Allows a player to register for the Avarati SA Campaign and Hunting Challenge
--  Syntax:  !register <command>
------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------
require("scripts/globals/status");
-------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = "ss"
}

function onTrigger(PC, Command, Sub)

    Command = Command or nil
    Sub = Sub or nil

    if not Command then
        PC:PrintToPlayer("Instructions", 29)
        PC:PrintToPlayer("!register help: Provides help with the usage of commands.", 29)
        return
    end
    
    Command = string.lower(Command)

    if Command == "help" then
        PC:PrintToPlayer("The sub-commands available for !register are as follows:", 29)
        PC:PrintToPlayer("!register sa: Registers for Avarati Strongest Adventurer Campaign.", 29)
        PC:PrintToPlayer("!register hunt: Registers for the Avarati Hunting Challenge.", 29)
        
    elseif Command == "sa" then
        PC:RegisterSA(Retrib.Event.Strongest)
        PC:PrintToPlayer("You have successfully registered for the Avarati Strongest Adventurer Campaign.", 29)
        PC:PrintToPlayer("This only needs to be done once.", 29)

    elseif Command == "hunt" then
            --local Rank = PC:GetRankings(Retrib.Event.Strongest, false)
            PC:PrintToPlayer("Avarati Hunting Challenge not yet implemented.  Please try again later.", 29)
        
    end

end
