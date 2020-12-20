-----------------------------------
-- Area: Al Zahbi
--  NPC: Zafif
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Al_Zahbi/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4612, 234000,    -- Scroll of Cure IV
        4616, 112000,    -- Scroll of Curaga II
        4617, 199320,    -- Scroll of Curaga III
        4653, 320000,    -- Scroll of Protect III
        4654, 911160,    -- Scroll of Protect IV
        4736, 855000,    -- Scroll of Protectra IV
        4629, 350000,    -- Scroll of Holy
        4647, 200000,    -- Scroll of Banishga II
        4625,  23300,    -- Scroll of Silena
        4626, 192000,    -- Scroll of Stona
        4627, 133000,    -- Scroll of Viruna
        4628,  85860,    -- Scroll of Cursna
        4868, 776000,    -- Scroll of Dispell
        4720, 270000,    -- Scroll of Flash
        4750, 993750,    -- Scroll of Reraise III
        4715, 285000     -- Scroll of Reprisal
    }

    player:showText(npc, ID.text.ZAFIF_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
