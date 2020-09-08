-------------------------------------------------------------------------------
--  Command: saevent
--  Details: Test SA event
--  Syntax:  !saevent
-------------------------------------------------------------------------------
cmdprops =
{
    permission = 1,
    parameters = "ss"
}
-------------------------------------------------------------------------------
require("scripts/globals/status");
-------------------------------------------------------------------------------
function onTrigger(PC, Command, Sub)

    Command = Command or nil
    Sub = Sub or nil

    if not Command then
        PC:PrintToPlayer("Instructions", 29)
        PC:PrintToPlayer("!saevent help: Provides help with the usage of commands.", 29)
        return
    end
    
    Command = string.lower(Command)

    if Command == "help" then
        PC:PrintToPlayer("The sub-commands available for !saevent are as follows:", 29)
        PC:PrintToPlayer("!saevent start: Starts a new Avarati Strongest Adventurer campaign.", 29)
        PC:PrintToPlayer("!saevent newday: Begins a new day for the Avarati Strongest Adventurer campaign.", 29)
        PC:PrintToPlayer("!saevent finish: Ends the Avarati Strongest Adventurer campaign.", 29)
        
    elseif Command == "start" then
        PC:SAEventState(Retrib.Event.Strongest, 1)
        PC:PrintToPlayer("You have successfully started a new Avarati Strongest Adventurer campaign.", 29)

    elseif Command == "newday" then
        PC:SAEventState(Retrib.Event.Strongest, 2)
        PC:PrintToPlayer("You have successfully began a new day of the Avarati Strongest Adventurer campaign.", 29)

    elseif Command == "finish" then
        PC:SAEventState(Retrib.Event.Strongest, 3)
        PC:PrintToPlayer("You have successfully ended the Avarati Strongest Adventurer campaign.", 29)
        
    end

end
