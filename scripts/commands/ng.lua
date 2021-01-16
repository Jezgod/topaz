---------------------------------------------------------------------------------------------------
-- func: ng
-- desc: Prints the ng status of player
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!ng <player>")
end

-- invert tpz.job table
    local jobNameByNum={}
    for k, v in pairs(tpz.job) do
        jobNameByNum[v]=k
    end

function onTrigger(player, arg1)
    local targ
    local ng = 0
    local ng_job = 0
    
    if (arg1 == nil) then
        targ = nil
    else
        targ = arg1
    end

    -- validate target
    if (targ == nil) then
        targ = player:getCursorTarget()
        if (targ == nil or not targ:isPC()) then
            targ = player
        end
    else
        local target = targ
        targ = GetPlayerByName(targ)
        if (targ == nil) then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    if (targ:getCharVar("ng") ~= nil) then
       ng = targ:getCharVar("ng")
    end

    if (targ:getCharVar("ng_job") ~= nil) then
       ng_job = targ:getCharVar("ng_job")
    end
    
    if (targ ~= nil) then
        local tokens = targ:getCharVar("atma_token")
        player:PrintToPlayer(string.format("%s's NG Status: %u | Job: %s | Level: %u | Atma Tokens: %u", targ:getName(), ng, jobNameByNum[ng_job], targ:getJobLevel(ng_job), tokens), 29)
    else
        player:PrintToPlayer("Must select a target using in game cursor first.")
    end
end
