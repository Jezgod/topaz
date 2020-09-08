---------------------------------------------------------------------------------------------------
-- func: !sa
-- desc: Used for the Avarai Strongest Adventurer Campaign
---------------------------------------------------------------------------------------------------
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
        PC:PrintToPlayer("!sa help: Provides help with the usage of commands for the Avarati Strongest Adventurer Campaign.", 29)
        return
    end
    
    Command = string.lower(Command)

    if Command == "help" then
        PC:PrintToPlayer("The sub-commands available for SA are as follows:", 29)
        PC:PrintToPlayer("!sa challenge: Displays today's challenge for earning points.", 29)
        PC:PrintToPlayer("!sa rewards: Lists the weekly and current day's rewards.", 29)
        PC:PrintToPlayer("!sa ranks daily: Lists the top 3 point leaders for the daily challenge, as well as your rank and points behind first place.", 29)
        PC:PrintToPlayer("!sa ranks weekly: Lists the top 3 point leaders for the weekly challenge, as well as your rank and points behind first place.", 29)
        PC:PrintToPlayer("!sa ranks overall: Lists the top 3 points leaders based on overall point accumulation, as well as your rank.", 29)
    elseif Command == "challenge" then
        local Task = PC:GetEventTask(Retrib.Event.Strongest)
        PC:PrintToPlayer("Today's Challenge: "..Task, 29)
    elseif Command == "rewards" then
        local Items = PC:GetEventRewards(Retrib.Event.Strongest)
        PC:PrintToPlayer("Overall Rewards:", 29)
        PC:PrintToPlayer("  1st: "..Items[1].." and "..Items[2].." gil.", 29)
        PC:PrintToPlayer("  2nd: "..Items[3].." and "..Items[4].." gil.", 29)
        PC:PrintToPlayer("  3rd: "..Items[5].." and "..Items[6].." gil.", 29)
        PC:PrintToPlayer("Today: "..Items[7].." "..Items[8], 29)
    elseif Command == "ranks" then
        if not Sub then
            PC:PrintToPlayer("Error. Please specify either \"!sa ranks daily\" or \"!sa ranks weekly\" or \"!sa ranks overall\".", 29)
            return
        end
        Sub = string.lower(Sub)
        if Sub == "daily" then
            local Rank = PC:GetRankings(Retrib.Event.Strongest, true)
	    local Dfplace = Rank[2]
	    local Dpplace = Rank[8]
	    local Dbehind = Dfplace - Dpplace
            PC:PrintToPlayer("Avarati Strongest Adventurer Campaign : DAILY Leaderboard", 29)
            PC:PrintToPlayer("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", 29) 
            PC:PrintToPlayer("1st: "..Rank[1].." - "..Rank[2].." | 2nd: "..Rank[3].." - "..Rank[4].." | 3rd: "..Rank[5].." - "..Rank[6].." | Your Rank: "..Rank[7].." (Points Behind 1st: "..Dbehind..")", 29)
            PC:PrintToPlayer("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", 29) 
        elseif Sub == "weekly" then
            local Rank = PC:GetRankings(Retrib.Event.Strongest, false)
	    local Wfplace = Rank[2]
	    local Wpplace = Rank[8]
	    local Wbehind = Wfplace - Wpplace
            PC:PrintToPlayer("Avarati Strongest Adventurer Campaign : WEEKLY Leaderboard", 29)
            PC:PrintToPlayer("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", 29)
            PC:PrintToPlayer("1st: "..Rank[1].." - "..Rank[2].." | 2nd: "..Rank[3].." - "..Rank[4].." | 3rd: "..Rank[5].." - "..Rank[6].." | Your Rank: "..Rank[7].." (Points Behind 1st: "..Wbehind..")", 29)
            PC:PrintToPlayer("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", 29)
        elseif Sub == "overall" then
            local Rank = PC:GetRankings(Retrib.Event.Overall)
	    local Ofplace = Rank[2]
	    local Opplace = Rank[8]
	    local Obehind = Ofplace - Opplace
            PC:PrintToPlayer("Avarati Strongest Adventurer Campaign : OVERALL Leaderboard", 29)
            PC:PrintToPlayer("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", 29)
            PC:PrintToPlayer("1st: "..Rank[1].." - "..Rank[2].." | 2nd: "..Rank[3].." - "..Rank[4].." | 3rd: "..Rank[5].." - "..Rank[6].." | Your Rank: "..Rank[7].." (Points Behind 1st: "..Obehind..")", 29)
            PC:PrintToPlayer("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", 29)
        end
    end
end
