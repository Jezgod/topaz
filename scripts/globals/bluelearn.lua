-----------------------------------------------------
-- Blue Learn By Kill
-----------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/zone")
require("scripts/globals/msg")
-----------------------------------------------------

tpz = tpz or {}
tpz.blu = tpz.blu or {}

function tpz.blu.checkBlueKill(mob, player, mobSpellID)
    local playerSpellID = player:getCharVar("[blu]" .. mobSpellID)
    local mJob = player:getMainJob() 

    -- required mob has been defeated
    if (mJob == tpz.job.BLU and not player:hasSpell(mobSpellID)) then
	if (playerSpellID == 10) then
	    player:PrintToPlayer("Required kills obtained to learn spell.", 29)
	else
            player:addCharVar("[blu]" .. mobSpellID, 1)
	end
    end
end