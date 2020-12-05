---------------------------------------------------------------------------------------------------
-- func: ng
-- desc: Prints the ng status of player
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
}

-- invert tpz.job table
    local jobNameByNum={}
    for k, v in pairs(tpz.job) do
        jobNameByNum[v]=k
    end

function onTrigger(player)
    local targ = player
    local ng = 0
    local ng_job = 0

    if (targ:getCharVar("ng") ~= nil) then
       ng = targ:getCharVar("ng")
    end

    if (targ:getCharVar("ng_job") ~= nil) then
       ng_job = targ:getCharVar("ng_job")
    end
    
    if (targ ~= nil) then
        player:PrintToPlayer(string.format("%s's NG Status: %u | Job: %s | Level: %u", targ:getName(), ng, jobNameByNum[ng_job], targ:getJobLevel(ng_job)), 29)
    else
        player:PrintToPlayer("Must select a target using in game cursor first.")
    end
end
