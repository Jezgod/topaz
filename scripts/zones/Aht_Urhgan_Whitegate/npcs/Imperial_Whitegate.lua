-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Imperial Whitegate
-- pos: 152, -2, 0, 50
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/besieged")
require("scripts/globals/npc_util")
require("scripts/zones/Aht_Urhgan_Whitegate/Shared")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/settings")
-----------------------------------

local mythic_map =
{
	[tpz.job.WAR] = {base = 18971, testimony = 1426},
	[tpz.job.MNK] = {base = 18972, testimony = 1427},
	[tpz.job.WHM] = {base = 18973, testimony = 1428},
	[tpz.job.BLM] = {base = 18974, testimony = 1429},
	[tpz.job.RDM] = {base = 18975, testimony = 1430},
	[tpz.job.THF] = {base = 18976, testimony = 1431},
	[tpz.job.PLD] = {base = 18977, testimony = 1432},
	[tpz.job.DRK] = {base = 18978, testimony = 1433},
	[tpz.job.BST] = {base = 18979, testimony = 1434},
	[tpz.job.BRD] = {base = 18980, testimony = 1435},
	[tpz.job.RNG] = {base = 18981, testimony = 1436},
	[tpz.job.SAM] = {base = 18982, testimony = 1437},
	[tpz.job.NIN] = {base = 18983, testimony = 1438},
	[tpz.job.DRG] = {base = 18984, testimony = 1439},
	[tpz.job.SMN] = {base = 18985, testimony = 1440},
	[tpz.job.BLU] = {base = 18986, testimony = 2331},
	[tpz.job.COR] = {base = 18987, testimony = 2332},
	[tpz.job.PUP] = {base = 18988, testimony = 2333},
	[tpz.job.DNC] = {base = 18969, testimony = 2556},
	[tpz.job.SCH] = {base = 18970, testimony = 2557}
}

function onTrade(player, npc, trade)
    local mjob = player:getMainJob()
    local pJobMap = mythic_map[mjob]
    local pLevel = player:getMainLvl()
    local currency = "infamy"
    local pI = player:getCurrency(currency)
    local rI = 10000
    local hasItem = trade:hasItemQty(pJobMap.testimony, 1)

    if pLevel ~= 75 then
	player:PrintToPlayer( string.format("Please try again when you are level 75."), 14 )
    elseif not hasItem then
	player:PrintToPlayer( string.format("Please trade the appropriate testimony for your job."), 14 )
    elseif pI < rI then
	player:PrintToPlayer( string.format("Please try again when you have enough Infamy."), 14 )
	player:PrintToPlayer( string.format("Player Amount: %u | Required Amount: %u", pI, rI), 14 )
    elseif (hasItem and pLevel == 75 and pI >= rI and 
	trade:getItemCount() == 1 and
        trade:getGil() == 0) then
              	
	player:tradeComplete()
    	player:addItem(pJobMap.base)
       	player:delCurrency(currency,rI)
    	player:messageSpecial(ID.text.ITEM_OBTAINED,pJobMap.base)
    end
end

function onTrigger(player, npc)
    if player:getEquipID(tpz.slot.MAIN) == 0 and player:getEquipID(tpz.slot.SUB) == 0 then
        if player:getCurrentMission(TOAU) == tpz.mission.id.toau.GUESTS_OF_THE_EMPIRE and player:getCharVar("AhtUrganStatus") == 1 and
                doRoyalPalaceArmorCheck(player) == true then
            player:startEvent(3078, 0, 1, 0, 0, 0, 0, 0, 1, 0)
        elseif player:getCurrentMission(TOAU) == tpz.mission.id.toau.SEAL_OF_THE_SERPENT then
            player:startEvent(3111)
        elseif player:getCurrentMission(TOAU) == tpz.mission.id.toau.IMPERIAL_CORONATION and
                doRoyalPalaceArmorCheck(player) == true then
            player:startEvent(3140, tpz.besieged.getMercenaryRank(player), player:getTitle(), 0, 0, 0, 0, 0, 0, 0)
        elseif player:getCurrentMission(TOAU) >= tpz.mission.id.toau.IMPERIAL_CORONATION and
                doRoyalPalaceArmorCheck(player) == true then
            local ring = player:getCharVar("TOAU_RINGTIME")
            local standard = player:hasItem(129)

            local ringParam = 0

            if ring == 0 then
                ringParam = 1
            end

            local standardParam = 0

            if standard == false then
                standardParam = 1
            end

            if ringParam > 0 or standardParam > 0 then
                player:startEvent(3155, standardParam, ringParam, 0, 0, 0, 0, 0, 0, 0)
            end
        end
    end
end

function onEventUpdate(player, csid, option)
    if csid == 3140 or csid == 3155 then
        if option == 1 and npcUtil.giveItem(player, 15807) then
            player:setCharVar("TOAU_RINGTIME", os.time())
            player:setCharVar("TOAU_RINGRECV", 1)
        elseif option == 2 and npcUtil.giveItem(player, 15808) then
            player:setCharVar("TOAU_RINGTIME", os.time())
            player:setCharVar("TOAU_RINGRECV", 1)
        elseif option == 3 and npcUtil.giveItem(player, 15809) then
            player:setCharVar("TOAU_RINGTIME", os.time())
            player:setCharVar("TOAU_RINGRECV", 1)
        elseif option == 4 then
            npcUtil.giveItem(player, 129)
        elseif option == 99 then
            player:updateEvent(15807, 15808, 15809)
        end
    end
end

function onEventFinish(player, csid, option)
    if csid == 3078 and npcUtil.giveItem(player, 2186) then
        player:completeMission(TOAU, tpz.mission.id.toau.GUESTS_OF_THE_EMPIRE)
        player:setCharVar("AhtUrganStatus", 0)
        player:addTitle(tpz.title.OVJANGS_ERRAND_RUNNER)
        player:needToZone(true)
        player:setCharVar("TOAUM18_STARTDAY", VanadielDayOfTheYear())
        player:addMission(TOAU, tpz.mission.id.toau.PASSING_GLORY)
    elseif csid == 3111 then
        player:completeMission(TOAU, tpz.mission.id.toau.SEAL_OF_THE_SERPENT)
        player:addMission(TOAU, tpz.mission.id.toau.MISPLACED_NOBILITY)
    elseif csid == 3140 and player:getCharVar("TOAU_RINGRECV") == 1 then
        player:completeMission(TOAU, tpz.mission.id.toau.IMPERIAL_CORONATION)
        player:addMission(TOAU, tpz.mission.id.toau.THE_EMPRESS_CROWNED)
        player:setCharVar("TOAU_RINGRECV", 0)
    elseif csid == 3155 and option == 6 then
        npcUtil.giveItem(player, 129)
    end
end
