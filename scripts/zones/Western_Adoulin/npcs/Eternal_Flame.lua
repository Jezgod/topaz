-----------------------------------
-- Area: Western Adoulin
-- NPC: Eternal Flame
-- Sparks NPC
-- !pos 
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
require("scripts/globals/shop")

local opt1  = "Armor"
local opt2  = "Weapons"

local armor =
{
    	27740, 300000, -- Outrider mask
	27881, 500000, --Outrider mail
	28029, 300000,  --Outrider mittens
	28168, 300000,  --Outrider hose
	28306, 300000,  --Outrider greaves
	27741, 300000,  --Espial cap
	27882, 500000,  --Espial gambison
	28030, 300000,  --Espial bracers
	28169, 300000,  --Espial hose
	28307, 300000,  --Espial socks
	27742, 300000,  --Wayfarer circlet
	27883, 500000,  --Wayfarer robe
	28031, 300000,  --Wayfarer cuffs
	28170, 300000,  --Wayfarer slops
	28308, 300000,  --Wayfarer clogs
	27743, 200000,  --Temachtiani headband
	27884, 300000,  --Temachtiani shirt
	28032, 200000,  --Temachtiani gloves
	28171, 200000,  --Temachtiani pants
	28309, 200000,  --Temachtiani boots
	28549, 1000000, --Enlivened ring
	28550, 1000000, --Vehemence ring
	28551, 1000000, --Longshot ring
	28552, 1000000, --Fistmele ring
	28553, 1000000, --Perception ring
	28554, 1000000, --Acumen ring
	28499, 1000000, --Influx earring
	28500, 1000000, --Upsurge earring
	28501, 1000000, --Allegro earing
	28502, 1000000, --Impregnable earring
	28503, 1000000, --Flashward earring
	28504, 1000000, --Spellbreaker earring
	28547, 1000000, --Merirosvo ring
}

local weapons =
{
    	20540, 700000,  -- Eminent baghnakhs
	20624, 700000,  -- Eminent dagger
	20726, 700000,  -- Eminent scimitar
	20766, 700000,  -- Eminent sword
	20817, 700000,  -- Eminent axe
	20865, 700000,  -- Eminent voulge
	20908, 700000,  -- Eminent sickle
	20954, 700000,  -- Eminent lance
	20998, 700000,  -- Kaitsuburi
	21044, 700000,  -- Ichimonji-yofusa
	21119, 700000,  -- Eminent wand
	21182, 700000,  -- Eminent staff
	21183, 700000,  -- Eminent pole
	21231, 700000,  -- Eminent bow
	21251, 700000,  -- Eminent crossbow
	21281, 700000,  -- Eminent gun
	28656, 700000,  -- Eminent shield
	21453, 700000,  -- Eminent animator
	21383, 700000,  -- Eminent sachet
	--21462, 1000000, -- Eminent bell
	21405, 1000000, -- Eminent flute
	21302, 5000,    -- Eminent arrow
	21316, 5000,    -- Eminent bolt
	21331, 5000,    -- Eminent bullet
	21355, 7000,    -- Hachiya shuriken
}
function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    player:SetEventNPC(npc:getID())
    player:PrintToPlayer(string.format("Sparks Level 99 Armor and Weapons"), 29);
    player:PrintToPlayer(string.format("Type? %s %s",opt1, opt2), 12)
end

function onMenuSelection(player, npc, Choice)
    local ChoiceData = 
    {
	{ choice = "Armor",       stock = armor   },
	{ choice = "Weapons",     stock = weapons },
    }

    for _, v in pairs(ChoiceData) do
        if v.choice == Choice then
            player:PrintToPlayer(string.format("Please choose from the available Sparks %s:", v.choice), 29);
            tpz.shop.general(player, v.stock)
        end
    end
end