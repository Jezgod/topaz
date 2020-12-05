-----------------------------------
-- Area: Pashhow Marshlands
--  NPC: Odyssean Passage
-- Working 100%
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands/IDs")
require("scripts/globals/settings");
require("scripts/globals/npc_util")
-----------------------------------

local skill_map =
{
	[18991] = {augment = 262, min = 0, max = 31},--Conqueror / Great Axe
	[18992] = {augment = 257, min = 0, max = 31},--Glanzfaust / Hand-to-Hand
	[18993] = {augment = 267, min = 0, max = 31},--Yagrush / Club
	[18994] = {augment = 268, min = 0, max = 31},--Laevateinn / Staff
	[18995] = {augment = 259, min = 0, max = 31},--Murgleis / Sword
	[18996] = {augment = 258, min = 0, max = 31},--Vajra / Dagger
	[18997] = {augment = 259, min = 0, max = 31},--Burtgang / Sword
	[18998] = {augment = 263, min = 0, max = 31},--Liberator / Scythe
	[18999] = {augment = 261, min = 0, max = 31},--Aymur / Axe
	[19000] = {augment = 258, min = 0, max = 31},--Carnwenhan / Dagger
	[19001] = {augment = 282, min = 0, max = 31},--Gastraphetes / Marskmanship
	[19002] = {augment = 266, min = 0, max = 31},--Kogarasumaru / Great Katana
	[19003] = {augment = 265, min = 0, max = 31},--Nagi / Katana
	[19004] = {augment = 264, min = 0, max = 31},--Ryunohige / Polearm
	[19005] = {augment = 268, min = 0, max = 31},--Nirvana / Staff
	[19006] = {augment = 259, min = 0, max = 31},--Tizona / Sword
	[19007] = {augment = 282, min = 0, max = 31},--Death Penalty / Marskmanship
	[19008] = {augment = 257, min = 0, max = 31},--Kenkonken / Great Axe
	[18989] = {augment = 258, min = 0, max = 31},--Terpsichore / Dagger
	[18990] = {augment = 268, min = 0, max = 31},--Tupsimati / Staff
}

local testimony_map =
{
	[1426] = {augment = 143, min = 0, max = 31}, 	--warriors_testimony / Dbl.Atk.+1
	[1427] = {augment =  45, min = 0, max = 31},	--monks_testimony / DMG:+1
	[1428] = {augment = 329, min = 0, max = 31}, 	--white_mages_testimony / Cure potency +1%
	[1429] = {augment = 133, min = 0, max = 31}, 	--black_mages_testimony / Mag.Atk.Bns.+1
	[1430] = {augment = 335, min = 0, max = 31}, 	--red_mages_testimony / Mag. crit. hit dmg. +1%
	[1431] = {augment =  31, min = 0, max = 31}, 	--thiefs_testimony / Evasion.+1
	[1432] = {augment =  54, min = 0, max = 31}, 	--paladins_testimony / Phys. dmg. taken -1%
	[1433] = {augment =  25, min = 0, max = 31}, 	--dark_knights_testimony / Attack+1
	[1434] = {augment = 327, min = 0, max = 31}, 	--beastmasters_testimony / Weapon skill damage +1%
	[1435] = {augment = 137, min = 0, max = 31}, 	--bards_testimony / Regen+1
	[1436] = {augment =  29, min = 0, max = 31}, 	--rangers_testimony / Rng.Atk.+1
	[1437] = {augment = 142, min = 0, max = 31}, 	--samurais_testimony / Store TP+1
	[1438] = {augment =  49, min = 0, max = 31}, 	--ninjas_testimony / Haste+1
	[1439] = {augment =  23, min = 0, max = 31}, 	--dragoons_testimony / Accuracy+1
	[1440] = {augment = 138, min = 0, max = 31}, 	--summoners_testimony / Refresh+1
	[2331] = {augment =  57, min = 0, max = 31}, 	--blue_mages_testimony / Magic crit. hit rate +1
	[2332] = {augment =  27, min = 0, max = 31}, 	--corsairs_testimony / Rng.Acc.+1
	[2333] = {augment =  41, min = 0, max = 31}, 	--puppetmasters_testimony / Crit.hit rate+1
	[2556] = {augment = 195, min = 0, max = 31}, 	--dancers_testimony / Subtle Blow +1
	[2557] = {augment =  35, min = 0, max = 31}, 	--scholars_testimony / Mag.Acc.+1
}

function onTrade(player,npc,trade)
	local currency = "imperial_standing"
	local pIS = player:getCurrency(currency)
        local rIS = 100000
        local weapon = trade:getItemId(0)
        local weaponMap = skill_map[weapon]
	local testimony = trade:getItemId(1)
        local testimonyMap = testimony_map[testimony]
        local aug1 = 0
        local aug2 = 0
	local aug1t = 0
	local aug2t = 0

        if (trade:getItemCount() ~= 2 or trade:getGil() ~= 0) then
		player:messageSpecial(ID.text.NOTHING_HAPPENS);

	elseif (weaponMap == nil or testimonyMap == nil) then
 		player:messageSpecial(ID.text.NOTHING_HAPPENS);
	
	elseif (trade:getItemCount() == 2 and trade:getGil() == 0 and pIS >= rIS) then		
		aug1 = weaponMap.augment
 		aug2 = testimonyMap.augment
		math.randomseed (os.time())
		--aug1t = math.random(weaponMap.min, weaponMap.max)
		--aug2t = math.random(testimonyMap.min, testimonyMap.max)
                aug1t = math.floor(math.abs(math.random() - math.random()) * (1 + weaponMap.max - weaponMap.min) + weaponMap.min)
		aug2t = math.floor(math.abs(math.random() - math.random()) * (1 + testimonyMap.max - testimonyMap.min) + testimonyMap.min)

		player:tradeComplete();
    		player:addItem(weapon, 1, aug1, aug1t, aug2, aug2t);
       		player:delCurrency(currency,rIS);
    		player:messageSpecial(ID.text.ITEM_OBTAINED,weapon);
        else
		player:messageSpecial(ID.text.NOTHING_HAPPENS);
	end	
   
        --player:PrintToPlayer( string.format("Weapon Augment1: %u Weapon Augment2: %u",aug1, aug2) );
	printf("random1: %u", aug1t)
	printf("random2: %u", aug2t)
end;

function onTrigger(player,npc)
	player:PrintToPlayer( string.format("Increase the Strength of Mythic Weapons Here...") )
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;