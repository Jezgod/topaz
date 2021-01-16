-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Yahsra
-- Type: Assault Mission Giver
-- !pos 120.967 0.161 -44.002 50
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/besieged")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    local hasRunic = tpz.besieged.hasRunicPortal(player, tpz.teleport.runic_portal.AZOUPH)
    local pIS = player:getCurrency("imperial_standing")
    local gil = trade:getGil()
    local gilsink = gil / 100
    local currency = "leujaoam_assault_point"
    local name = "Leujaoam Assault Points"

    if (hasRunic == true) then
        --player:PrintToPlayer( string.format( "%s", hasRunic ), 29)
        if (gilsink <= pIS and trade:getItemCount() == 1) then
	    player:tradeComplete()
            --player:AddAssaultPoint(0, gilsink)
            player:addCurrency(currency, gilsink)
	    player:delCurrency("imperial_standing", gilsink)
            player:PrintToPlayer( string.format( "Successful conversion of %u Imperial Standing to %u %s for %u gil.", gilsink, gilsink, name, gil ), 29)
        else
	    player:PrintToPlayer( string.format( "You do not have enough Imperial Standing currency for this conversion." ), 14)
        end
    else
        player:PrintToPlayer( string.format( "You have not interacted with the proper runic portal." ), 14)
    end
end

function onTrigger(player, npc)
    --local rank = tpz.besieged.getMercenaryRank(player)
    local rank = 12
    local haveimperialIDtag
    local assaultPoints = player:getAssaultPoint(LEUJAOAM_ASSAULT_POINT)

    if player:hasKeyItem(tpz.ki.IMPERIAL_ARMY_ID_TAG) then
        haveimperialIDtag = 1
    else
        haveimperialIDtag = 0
    end

    if (rank > 0 and haveimperialIDtag == 1) then
        player:startEvent(273, rank, haveimperialIDtag, assaultPoints, player:getCurrentAssault())
    else
        player:startEvent(279) -- no rank
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local currency = "leujaoam_assault_point"

    if csid == 273 then
        local selectiontype = bit.band(option, 0xF)
	--[[
        if selectiontype == 1 then
            -- taken assault mission
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(tpz.ki.IMPERIAL_ARMY_ID_TAG)
            player:addKeyItem(tpz.ki.LEUJAOAM_ASSAULT_ORDERS)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LEUJAOAM_ASSAULT_ORDERS)
	--]]
        if selectiontype == 2 then
            -- purchased an item
            local item = bit.rshift(option, 14)
            local itemID = 0
            local price = 0
            local items =
            {
                [1]  = {itemid = 15970, price = 3000},
                [2]  = {itemid = 15775, price = 5000},
                [3]  = {itemid = 15521, price = 8000},
                [4]  = {itemid = 15884, price = 10000},
                [5]  = {itemid = 15490, price = 10000},
                [6]  = {itemid = 18408, price = 10000},
                [7]  = {itemid = 18485, price = 15000},
                [8]  = {itemid = 18365, price = 15000},
                [9]  = {itemid = 14933, price = 15000},
                [10] = {itemid = 16069, price = 20000},
                [11] = {itemid = 15606, price = 20000},
            }

            local choice = items[item]
            if choice and npcUtil.giveItem(player, choice.itemid) then
                --player:delAssaultPoint(LEUJAOAM_ASSAULT_POINT, choice.price)
		player:delCurrency(currency, choice.price)
            end
        end
    end
end
