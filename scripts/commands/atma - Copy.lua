---------------------------------------------------------------------------------------------------
-- func: atma
-- desc: Adds the given atma to a player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/atma")
require("scripts/globals/keyitems")

cmdprops =
{
    permission = 0,
    parameters = "i"
}

local atma_map =
{
	[1279]		=	"ATMA_OF_THE_LION",
	[1280]		=	"ATMA_OF_THE_STOUT_ARM",
	[1281]		=	"ATMA_OF_THE_TWIN_CLAW",
	[1282]		=	"ATMA_OF_ALLURE",
	[1283]		=	"ATMA_OF_ETERNITY",
	[1284]		=	"ATMA_OF_THE_HEAVENS",
	[1285]		=	"ATMA_OF_THE_BAYING_MOON",
	[1286]		=	"ATMA_OF_THE_EBON_HOOF",
	[1287]		=	"ATMA_OF_TREMORS",
	[1288]		=	"ATMA_OF_THE_SAVAGE_TIGER",
	[1289]		=	"ATMA_OF_THE_VORACIOUS_VIOLET",
	[1290]		=	"ATMA_OF_CLOAK_AND_DAGGER",
	[1291]		=	"ATMA_OF_THE_STORMBIRD",
	[1292]		=	"ATMA_OF_THE_NOXIOUS_FANG",
	[1293]		=	"ATMA_OF_VICISSITUDE",
	[1294]		=	"ATMA_OF_THE_BEYOND",
	[1295]		=	"ATMA_OF_STORMBREATH",
	[1296]		=	"ATMA_OF_GALES",
	[1297]		=	"ATMA_OF_THRASHING_TENDRILS",
	[1298]		=	"ATMA_OF_THE_DRIFTER",
	[1299]		=	"ATMA_OF_THE_STRONGHOLD",
	[1300]		=	"ATMA_OF_THE_HARVESTER",
	[1301]		=	"ATMA_OF_DUNES",
	[1302]		=	"ATMA_OF_THE_COSMOS",
	[1303]		=	"ATMA_OF_THE_SIREN_SHADOW",
	[1304]		=	"ATMA_OF_THE_IMPALER",
	[1305]		=	"ATMA_OF_THE_ADAMANTINE",
	[1306]		=	"ATMA_OF_CALAMITY",
	[1307]		=	"ATMA_OF_THE_CLAW",
	[1308]		=	"ATMA_OF_BALEFUL_BONES",
	[1309]		=	"ATMA_OF_THE_CLAWED_BUTTERFLY",
	[1310]		=	"ATMA_OF_THE_DESERT_WORM",
	[1311]		=	"ATMA_OF_THE_UNDYING",
	[1312]		=	"ATMA_OF_THE_IMPREGNABLE_TOWER",
	[1313]		=	"ATMA_OF_THE_SMOLDERING_SKY",
	[1314]		=	"ATMA_OF_THE_DEMONIC_SKEWER",
	[1315]		=	"ATMA_OF_THE_GOLDEN_CLAW",
	[1316]		=	"ATMA_OF_THE_GLUTINOUS_OOZE",
	[1317]		=	"ATMA_OF_THE_LIGHTNING_BEAST",
	[1318]		=	"ATMA_OF_THE_NOXIOUS_BLOOM",
	[1319]		=	"ATMA_OF_THE_GNARLED_HORN",
	[1320]		=	"ATMA_OF_THE_STRANGLING_WIND",
	[1321]		=	"ATMA_OF_THE_DEEP_DEVOURER",
	[1322]		=	"ATMA_OF_THE_MOUNTED_CHAMPION",
	[1323]		=	"ATMA_OF_THE_RAZED_RUINS",
	[1324]		=	"ATMA_OF_THE_BLUDGEONING_BRUTE",
	[1325]		=	"ATMA_OF_THE_RAPID_REPTILIAN",
	[1326]		=	"ATMA_OF_THE_WINGED_ENIGMA",
	[1327]		=	"ATMA_OF_THE_CRADLE",
	[1328]		=	"ATMA_OF_THE_UNTOUCHED",
	[1329]		=	"ATMA_OF_THE_SANGUINE_SCYTHE",
	[1330]		=	"ATMA_OF_THE_TUSKED_TERROR",
	[1331]		=	"ATMA_OF_THE_MINIKIN_MONSTROSITY",
	[1332]		=	"ATMA_OF_THE_WOULD_BE_KING",
	[1333]		=	"ATMA_OF_THE_BLINDING_HORN",
	[1334]		=	"ATMA_OF_THE_DEMONIC_LASH",
	[1335]		=	"ATMA_OF_APPARITIONS",
	[1336]		=	"ATMA_OF_THE_SHIMMERING_SHELL",
	[1337]		=	"ATMA_OF_THE_MURKY_MIASMA",
	[1338]		=	"ATMA_OF_THE_AVARICIOUS_APE",
	[1339]		=	"ATMA_OF_THE_MERCILESS_MATRIARCH",
	[1340]		=	"ATMA_OF_THE_BROTHER_WOLF",
	[1341]		=	"ATMA_OF_THE_EARTH_WYRM",
	[1342]		=	"ATMA_OF_THE_ASCENDING_ONE",
	[1343]		=	"ATMA_OF_THE_SCORPION_QUEEN",
	[1344]		=	"ATMA_OF_A_THOUSAND_NEEDLES",
	[1345]		=	"ATMA_OF_THE_BURNING_EFFIGY",
	[1346]		=	"ATMA_OF_THE_SMITING_BLOW",
	[1347]		=	"ATMA_OF_THE_LONE_WOLF",
	[1348]		=	"ATMA_OF_THE_CRIMSON_SCALE",
	[1349]		=	"ATMA_OF_THE_SCARLET_WING",
	[1350]		=	"ATMA_OF_THE_RAISED_TAIL",
	[1351]		=	"ATMA_OF_THE_SAND_EMPEROR",
	[1352]		=	"ATMA_OF_THE_OMNIPOTENT",
	[1353]		=	"ATMA_OF_THE_WAR_LION",
	[1354]		=	"ATMA_OF_THE_FROZEN_FETTERS",
	[1355]		=	"ATMA_OF_THE_PLAGUEBRINGER",
	[1356]		=	"ATMA_OF_THE_SHRIEKING_ONE",
	[1357]		=	"ATMA_OF_THE_HOLY_MOUNTAIN",
	[1358]		=	"ATMA_OF_THE_LAKE_LURKER",
	[1359]		=	"ATMA_OF_THE_CRUSHING_CUDGEL",
	[1360]		=	"ATMA_OF_PURGATORY",
	[1361]		=	"ATMA_OF_BLIGHTED_BREATH",
	[1362]		=	"ATMA_OF_THE_PERSISTENT_PREDATOR",
	[1363]		=	"ATMA_OF_THE_STONE_GOD",
	[1364]		=	"ATMA_OF_THE_SUN_EATER",
	[1365]		=	"ATMA_OF_THE_DESPOT",
	[1366]		=	"ATMA_OF_THE_SOLITARY_ONE",
	[1367]		=	"ATMA_OF_THE_WINGED_GLOOM",
	[1368]		=	"ATMA_OF_THE_SEA_DAUGHTER",
	[1369]		=	"ATMA_OF_THE_HATEFUL_STREAM",
	[1370]		=	"ATMA_OF_THE_FOE_FLAYER",
	[1371]		=	"ATMA_OF_THE_ENDLESS_NIGHTMARE",
	[1372]		=	"ATMA_OF_THE_SUNDERING_SLASH",
	[1373]		=	"ATMA_OF_ENTWINED_SERPENTS",
	[1374]		=	"ATMA_OF_THE_HORNED_BEAST",
	[1375]		=	"ATMA_OF_AQUATIC_ARDOR",
	[1376]		=	"ATMA_OF_THE_FALLEN_ONE",
	[1377]		=	"ATMA_OF_FIRES_AND_FLARES",
	[1378]		=	"ATMA_OF_THE_APOCALYPSE",
}

local zone_list =
{
        --6,     --BEARCLAW PINNACLE
        --8,     --BONEYARD GULLY
        --10,    --THE SHROUDED MAW
        --13,    --MINE SHAFT 2716
	--15, 	 --Abyssea-Konschtat
        --17,    --SPIRE OF HOLLA
        --19,    --SPIRE OF DEM
        --21,    --SPIRE OF MEA
        --23,    --SPIRE OF VAHZL
        --29,    --RIVERNE SITE #B01
        --30,    --RIVERNE SITE #A01
        --31,    --MONARCH LINN
        --32,    --SEALION'S DEN
        --33,    --AlTaieu
        --34,    --Grand Palace of Hux
        --35,    --THE GARDEN OF RU'HMET
        --36,    --Empyreal Paradox
        --37,    --TEMENOS
        --38,    --APOLLYON
        --39,    --Dynamis-Valkurm
        --40,    --Dynamis-Buburimu
        --41,    --Dynamis-Qufim
        --42,    --Dynamis-Tavnazia
        --45, 	 --Abyssea-Tahrongi
        --57,    --TALACCA COVE
        --64,    --NAVUKGO EXECUTION CHAMBER
        --67,    --JADE SEPULCHER
	  71,	 -- THE_COLOSSUEM
        --78,    --HAZHALM TESTING GROUNDS
       --127,    --Behemoths_Dominion
       --128,    --Valley_of_Sorrows
       --130,    --RuAun_Gardens
       --132, 	 --Abyssea-La_Theine
       --134,    --Dynamis-Beaucedine
       --135,    --Dynamis-Xarcabard
       --139,    --HORLAIS PEAK
       --140,    --GHELSBA OUTPOST
       --144,    --WAUGHROON SHRINE
       --146,    --BALGA'S DIAS
       --154,    --Dragons_Aery
       --156,    --THRONE ROOM [S]
       --163,    --SACRIFICIAL CHAMBER
       --165,    --THRONE ROOM
       --168,    --CHAMBER OF ORACLES
       --170,    --FULL MOON FOUNTAIN
       --177,    --VeLugannon_Palace
       --178,    --The_Shrine_of_RuAvitau
       --179,    --STELLAR FULCRUM
       --180,    --LALOFF AMPHITHEATER
       --181,    --THE CELESTIAL NEXUS
       --185,    --Dynamis-San_dOria
       --186,    --Dynamis-Bastok
       --187,    --Dynamis-Windurst
       --188,    --Dynamis-Jeuno
       --201,    --CLOISTER OF GALES
       --202,    --CLOISTER OF STORMS
       --203,    --CLOISTER OF FROST
       --206,    --QU'BIA ARENA
       --207,    --CLOISTER OF FLAMES
       --209,    --CLOISTER OF TREMORS
       --211,    --CLOISTER OF TIDES
       --215, 	 --Abyssea-Attohwa
       --216, 	 --Abyssea-Misareaux
       --217, 	 --Abyssea-Vunkerl
       --218, 	 --Abyssea-Altepa
       --253, 	 --Abyssea-Uleguerand
       --254, 	 --Abyssea-Grauberg
       --255 	 --Abyssea-Empyreal_Paradox
}

local function validZone(zone_list, id)
	for k,v in pairs(zone_list) do
		if v == id then
		return true
 		end
 	end
end

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!atma <atma_offset>")
end

-- returns Lunar Abyssites
function getLunarAbyssiteTotal(player, abyssite)
    local LUNAR = 0
    if abyssite == "LUNAR" then
    	for ki = tpz.ki.LUNAR_ABYSSITE1, tpz.ki.LUNAR_ABYSSITE3 do
        	if player:hasKeyItem(ki) then
            		LUNAR = LUNAR + 1
        	end
    	end
        return LUNAR
    end
end

function onTrigger(player, arg1)
    local targ = player
    local zone = targ:getZoneID()
    local abysstotal = getLunarAbyssiteTotal(targ, "LUNAR")
    local abyssmod = abysstotal + 1 
    local id = tpz.effect.ATMA
    local duration = 3600
    local infused = 0
    local mJob = player:getMainJob()
    local ng_job = 0
    printf("Count Lunar: %i", abysstotal)

    if validZone(zone_list, zone) == true then
	    targ:PrintToPlayer( string.format( "This function is not valid in the current zone." ), 14)
        return
    else
    end  

    if (abysstotal == 0) then
        targ:PrintToPlayer( string.format( "You do not possess any lunar abyssite to infuse atma." ), 14)
        return
    elseif (targ:getCharVar("infused_atma") == abyssmod) then
        targ:PrintToPlayer( string.format( "You cannot infuse any more atma." ), 14)
        return
    elseif (targ:getCharVar("infused_atma") < abyssmod) then
        if (arg1 == nil or arg1 < 1 or arg1 > 100) then
	    --targ:PrintToPlayer( string.format( "Invalid atma.  Offset values are between 1 and 100." ), 14)
            error(player, "Invalid atma.  Offset values are between 1 and 100.")
            return
        else
            atma = arg1 + 1278
            if (player:getCharVar("ng_job") ~= nil) then
                ng_job = player:getCharVar("ng_job")
    	    end
	    if (targ:hasKeyItem(atma) and targ:getLocalVar("last_atma") ~= arg1 and mJob == ng_job) then
	        targ:addStatusEffect(id, arg1, 3, duration)
                targ:PrintToPlayer( string.format( "%s has been successfully infused.", atma_map[atma] ), 29)
                targ:addCharVar("infused_atma", 1)
                targ:setLocalVar("last_atma", arg1)
                targ:setLocalVar("atma_cooldown", os.time() + 1800)
            elseif (targ:getLocalVar("last_atma") == arg1) then
                targ:PrintToPlayer( string.format( "The same atma cannot be infused consecutively." ), 14)
            elseif (mJob ~= ng_job) then
                targ:PrintToPlayer( string.format( "This job cannot infuse atma." ), 14)
            else
	       targ:PrintToPlayer( string.format( "You do not possess the proper key item to infuse %s", atma_map[atma] ), 14)
            end
        end
    else
        targ:PrintToPlayer( string.format( "You cannot infuse any more atma." ))
    end
end