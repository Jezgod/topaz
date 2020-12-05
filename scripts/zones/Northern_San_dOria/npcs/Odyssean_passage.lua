-----------------------------------
--  Area: Northern San d'Oria
--  NPC: Odyssean Passage
--  Working 100%
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/settings");
require("scripts/globals/npc_util")
-----------------------------------

local skill_map =
{
	[18264] = {augment = 257, min = 0, max = 31}, 	--Spharai / Hand-to-Hand
	[18276] = {augment = 259, min = 0, max = 31}, 	--Excalibur / Sword
	[18294] = {augment = 262, min = 0, max = 31}, 	--Bravura / Great Axe
	[18306] = {augment = 263, min = 0, max = 31}, 	--Apocalypse / Scythe
	[18312] = {augment = 265, min = 0, max = 31}, 	--Kikoku / Katana
	[18324] = {augment = 267, min = 0, max = 31}, 	--Mjollnir / Club
	[18348] = {augment = 281, min = 0, max = 31}, 	--Yoichinoyumi / Great Katana
	[18342] = {augment = 298, min = 0, max = 31}, 	--Gjallahorn / Wind Instrument
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
	local pCP = player:getCP()
	local rCP = 100000
        local weapon = trade:getItemId(0)
        local weaponMap = skill_map[weapon]
	local testimony = trade:getItemId(1)
        local testimonyMap = testimony_map[testimony]
        local aug1 = 0
        local aug2 = 0
	local aug1t = 0
	local aug2t = 0
        local scyld = player:getCurrency("scyld")
	local scyldbonus = 0

        if (trade:getItemCount() ~= 2 or trade:getGil() ~= 0) then
		player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED);
	        printf("A")

	elseif (weaponMap == nil or testimonyMap == nil) then
 		player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED);
		printf("B")
	
	elseif (trade:getItemCount() == 2 and trade:getGil() == 0 and pCP >= rCP) then		
		aug1 = weaponMap.augment
 		aug2 = testimonyMap.augment
		math.randomseed (os.time())
		
		if (scyld == nil or scyld == 0) then
		    scyldbonus = 0
 		    printf("C")
		else
		    scyldbonus = math.floor(scyld / 100)
		    printf("D")
		end

                if (scyldbonus > 0) then
			aug1t = math.floor(math.abs(math.random() - math.random()) * (scyldbonus + 1 + weaponMap.max - weaponMap.min) + weaponMap.min)
			aug2t = math.floor(math.abs(math.random() - math.random()) * (scyldbonus + 1 + testimonyMap.max - testimonyMap.min) + testimonyMap.min)
			if (aug1t > 32) then
			    aug1t = 32
			else
			    aug1t = aug1t	
			end
			if (aug2t > 32) then
			    aug2t = 32
			else
			    aug2t = aug2t	
			end
		else
                	aug1t = math.floor(math.abs(math.random() - math.random()) * (1 + weaponMap.max - weaponMap.min) + weaponMap.min)
			aug2t = math.floor(math.abs(math.random() - math.random()) * (1 + testimonyMap.max - testimonyMap.min) + testimonyMap.min)
		end
		
		player:tradeComplete();
    		player:addItem(weapon, 1, aug1, aug1t, aug2, aug2t);
       		player:delCP(rCP);
  		if (scyldbonus > 0) then
			player:PrintToPlayer( string.format("%u Scyld used.", scyld), 29 )
			player:delCurrency("scyld", scyld);
		else
		end
    		player:messageSpecial(ID.text.ITEM_OBTAINED,weapon);
	        player:PrintToPlayer( string.format("Scyld Bonus: %u", scyldbonus), 29 )
        else
		player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED);
	end	

	printf("random1: %u", aug1t)
	printf("random2: %u", aug2t)
end;

function onTrigger(player,npc)
	player:PrintToPlayer( string.format("Increase the Strength of Relic Weapons Here..."), 29 )
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;