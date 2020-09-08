---------------------------------------------------------------------------------------------------
-- func: bounty
-- desc: Top 3 players ranked by bounty_points
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!bounty");
end;

function onTrigger(player)
    local Rank = player:getBounty(Retrib.Event.Bounty);
    local Points = player:getBountyPoints(Retrib.Event.Bounty);
    --local varName = "bounty_points";   
	
    player:PrintToPlayer("BOUNTY POINTS LIST: HIGHER VALUE, HIGHER REWARD", 29)
    player:PrintToPlayer("-------------------------------------------------------------------------", 29)
    player:PrintToPlayer("1st: "..Rank[1].." - "..Points[1].." | 2nd: "..Rank[2].." - "..Points[2].." | 3rd: "..Rank[3].." - "..Points[3], 14)
    player:PrintToPlayer("-------------------------------------------------------------------------", 29)
end