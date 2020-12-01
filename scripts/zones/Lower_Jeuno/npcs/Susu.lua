-----------------------------------
-- Area: Lower Jeuno
--  NPC: Susu
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4867,   87200,    -- Scroll of Sleep II
        4881,  112000,    -- Scroll of Sleepga
        4769,  199320,    -- Scroll of Stone III
        4770, 1080000,    -- Scroll of Stone IV
        4798,  120000,    -- Scroll of Stonega II
        4799,  698750,    -- Scroll of Stonega III
        4779,  226820,    -- Scroll of Water III
        4780, 1160000,    -- Scroll of Water IV
        4808,  130500,    -- Scroll of Waterga II
        4809,  822500,    -- Scroll of Waterga III
        4764,  277440,    -- Scroll of Aero III
        4765, 1317500,    -- Scroll of Aero IV
        4793,  198000,    -- Scroll of Aeroga II
        4794,  956250,    -- Scroll of Aeroga III
        4754,  333060,    -- Scroll of Fire III
        4755, 1485000,    -- Scroll of Fire IV
        4783,  213070,    -- Scroll of Firaga II
        4784, 1120000,    -- Scroll of Firaga III
        4759,  393680,    -- Scroll of Blizzard III
        4760, 1662500,    -- Scroll of Blizzard IV
        4788,  262440,    -- Scroll of Blizzaga II
        4789, 1275000,    -- Scroll of Blizzaga III
        4774,  459300,    -- Scroll of Thunder III
        4775, 1850000,    -- Scroll of Thunder IV
        4803,  316810,    -- Scroll of Thundaga II
        4804, 1440000,    -- Scroll of Thundaga III
        4818,  600000,    -- Scroll of Quake
        4822,  675000,    -- Scroll of Flood
        4816,  562500,    -- Scroll of Tornado
        4812,  712500,    -- Scroll of Flare
        4814,  525000,    -- Scroll of Freeze
        4820,  637500,    -- Scroll of Burst
        4813, 1191800,    -- Scroll of Flare II
        4815, 1191800,    -- Scroll of Freeze II
        4817, 1191800,    -- Scroll of Tornado II
        4819, 1191800,    -- Scroll of Quake II
        4821, 1191800,    -- Scroll of Burst II
        4823, 1191800,    -- Scroll of Flood II
        4840, 1391250,    -- Scroll of Bio III
        4884, 1391250,    -- Scroll of Blind II
    }

    player:showText(npc, ID.text.SUSU_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
