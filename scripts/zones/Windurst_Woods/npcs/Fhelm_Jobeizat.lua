-----------------------------------
-- Area: Windurst Woods
-- NPC: Fhelm Jobeizat
-- Sparks NPC
-- !pos 89.049 -4.108 -46.195 219
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/shop")

local opt1	=	  "1-9"
local opt2	=	"10-19"
local opt3	=	"20-29"
local opt4	=	"30-39"
local opt5	=	"40-50"
local opt6	=	"51-59"
local opt7	=	"60-69"
local opt8	=	  "70+"

-- Level 1-9
    local stockA =
    {

        16385, 500, 3, --cesti
	16390, 500, 3, --bronze_knuckles
	16391, 500, 3, --brass_knuckles
	16448, 500, 3, --bronze_dagger
	16465, 500, 3, --bronze_knife
	16454, 500, 3, --blind_dagger
	16471, 500, 3, --blind_knife
	16449, 500, 3, --brass_dagger
	16600, 500, 3, --wax_sword
	16530, 500, 3, --xiphos
	16640, 500, 3, --bronze_axe
	16641, 500, 3, --brass_axe
	16704, 500, 3, --butterfly_axe
	16709, 500, 3, --inferno_axe
	16768, 500, 3, --bronze_zaghnal
	16832, 500, 3, --harpoon
	16833, 500, 3, --bronze_spear
	16896, 500, 3, --kunai
	16900, 500, 3, --wakizashi
	16966, 500, 3, --tachi
	17024, 500, 3, --ash_club
	17034, 500, 3, --bronze_mace
	17042, 500, 3, --bronze_hammer
	17059, 500, 3, --bronze_rod
	17050, 500, 3, --willow_wand
	17088, 500, 3, --ash_staff
	17095, 500, 3, --ash_pole
	17152, 500, 3, --shortbow
	17160, 500, 3, --longbow
	17153, 500, 3, --self_bow
	17216, 500, 3, --light_crossbow
	19224, 500, 3, --musketoon
	17345, 500, 3, --flute
	17344, 500, 3, --cornette
	17347, 500, 3, --piccolo
	17353, 500, 3, --maple_harp
	12448, 500, 3, --bronze_cap
	12576, 500, 3, --bronze_harness
	12704, 500, 3, --bronze_mittens
	12832, 500, 3, --bronze_subligar
	12960, 500, 3, --bronze_leggings
	12472, 500, 3, --circlet
	12600, 500, 3, --robe
	12728, 500, 3, --cuffs
	12856, 500, 3, --slops
	12984, 500, 3, --ash_clogs
	12440, 500, 3, --leather_bandana
	12568, 500, 3, --leather_vest
	12696, 500, 3, --leather_gloves
	12824, 500, 3, --leather_trousers
	12952, 500, 3, --leather_highboots
	12608, 500, 3, --tunic
	12736, 500, 3, --mitts
	12864, 500, 3, --slacks
	12992, 500, 3, --solea
	12456, 500, 3, --hachimaki
	12584, 500, 3, --kenpogi
	12712, 500, 3, --tekko
	12840, 500, 3, --sitabaki
	12968, 500, 3, --kyahan
	12289, 500, 3, --lauan_shield
	12415, 500, 3, --shell_shield
	12290, 500, 3, --maple_shield
	12299, 500, 3, --aspis

    }

   -- Level 10-19
   local stockB =
    {
 
        16407, 6000, 3,  --brass_baghnakhs
	16450, 6000, 3,  --dagger
	16466, 6000, 3,  --knife
	16455, 8000, 3,  --baselard
	16572, 7000, 3,  --bee_spatha
	16531, 8000, 3,  --brass_xiphos
	16536, 13200, 3, --iron_sword
	16583, 6000, 3,  --claymore
	16588, 9800, 3,  --flame_claymore
	16642, 9300, 3,  --bone_axe
	16649, 6000, 3,  --bone_pick
	16705, 9100, 3,  --greataxe
	16769, 6000, 3,  --brass_zaghnal
	16774, 17700, 3, --scythe
	16834, 6000, 3,  --brass_spear
	18076, 6000, 3,  --spark_spear
	16919, 9300, 3,  --shinobi-gatana
	16906, 8900, 3,  --mokuto
	16960, 6800, 3,  --uchigatana
	16982, 13500, 3, --nodachi
	17043, 6000, 3,  --brass_hammer
	17081, 6000, 3,  --brass_rod
	17025, 6000, 3,  --chestnut_club
	17051, 6000, 3,  --yew_wand
	17035, 8100, 3,  --mace
	17089, 6000, 3,  --holly_staff
	17096, 6000, 3,  --holly_pole
	17161, 9900, 3,  --power_bow
	17217, 6000, 3,  --crossbow
	17257, 20000, 3, --bandits_gun
	17265, 18700, 3, --tanegashima
	17351, 8600, 3,  --gemshorn
	17354, 6000, 3,  --harp
	12432, 6000, 3,  --faceguard
	12560, 6000, 3,  --scale_mail
	12688, 6000, 3,  --scale_finger_gauntlets
	12816, 6000, 3,  --scale_cuisses
	12944, 6000, 3,  --scale_greaves
	12464, 6000, 3,  --headgear
	12592, 6000, 3,  --doublet
	12720, 6000, 3,  --gloves
	12848, 6000, 3,  --brais
	12976, 6000, 3,  --gaiters
	12454, 6500, 3,  --bone_mask
	12582, 6000, 3,  --bone_harness
	12710, 6000, 3,  --bone_mittens
	12834, 6000, 3,  --bone_subligar
	12966, 6000, 3,  --bone_leggings
	12441, 6000, 3,  --lizard_helm
	12569, 6000, 3,  --lizard_jerkin
	12697, 6000, 3,  --lizard_gloves
	12825, 6000, 3,  --lizard_trousers
	12953, 6000, 3,  --lizard_ledelsens
	12291, 6000, 3,  --elm_shield

    }

    -- Level 20-29
    local stockC =
    {
 
        16392, 8700, 3, --metal_knuckles
	16406, 14400, 3, --baghnakhs
	16387, 9900, 3,  --poison_cesti
	16473, 10300, 3, --kukri
	16496, 9600, 3,  --poison_dagger
	16472, 12300, 3, --poison_knife
	16451, 14300, 3, --mythril_dagger
	16517, 17000, 3, --degen
	16513, 21500, 3, --tuck
	16532, 26900, 3, --gladius
	16593, 7000, 3,  --plain_sword
	16594, 34900, 3, --inferno_sword
	16643, 13600, 3, --battleaxe
	17942, 8300, 3,  --tomahawk
	16770, 20900, 3, --zaghnal
	16835, 8400, 3,  --spear
	17776, 10300, 3, --hibari
	16907, 12000, 3, --busuto
	17044, 10900, 3, --warhammer
	17090, 7000, 3,  --elm_staff
	17424, 7000, 3,  --spiked_club
	17154, 13200, 3, --wrapped_bow
	17248, 52000, 3, --arquebus
	17259, 43200, 3, --pirates_gun
	15207, 7000, 3,  --traders_chapeau
	14446, 7100, 3,  --traders_saio
	14053, 7000, 3,  --traders_cuffs
	15404, 7000, 3,  --traders_slops
	15343, 7000, 3,  --traders_pigaches
	12424, 17100, 3, --iron_mask
	12552, 26400, 3, --chainmail
	12680, 14100, 3, --chain_mittens
	12808, 21000, 3, --chain_hose
	12936, 12900, 3, --greaves
	15165, 19500, 3, --shade_tiara
	14426, 52500, 3, --shade_harness
	14858, 30100, 3, --shade_mittens
	14327, 35400, 3, --shade_tights
	15315, 37900, 3, --shade_leggings
	15167, 25000, 3, --eisenschaller
	14431, 25000, 3, --eisenbrust
	14860, 17000, 3, --eisenhentzes
	14329, 14000, 3, --eisendiechlings
	15317, 29000, 3, --eisenschuhs
	15163, 7000, 3,  --seers_crown
	14424, 23400, 3, --seers_tunic
	14856, 9700, 3,  --seers_mitts
	14325, 13700, 3, --seers_slacks
	15313, 15700, 3, --seers_pumps
	12292, 8300, 3,  --mahogany_shield
	12414, 7000, 3,  --turtle_shield
	12306, 15300, 3, --kite_shield

    }

    -- Level 30-39   
    local stockD =
    {
 
        16411, 18200, 3, --claws
	16399, 19400, 3, --katars
	16393, 23000, 3, --mythril_knuckles
	19105, 31700, 3, --thugs_jambiya
	16475, 24800, 3, --mythril_kukri
	16456, 19800, 3, --mythril_baselard
	16545, 33400, 3, --broadsword
	16576, 49700, 3, --hunting_sword
	16581, 43000, 3, --holy_sword
	16549, 49300, 3, --divine_sword
	18375, 53200, 3, --falx
	16584, 52500, 3, --mythril_claymore
	17955, 8000, 3,  --plain_pick
	16644, 54000, 3, --mythril_axe
	18214, 29700, 3, --voulge
	16706, 51500, 3, --heavy_axe
	16845, 15400, 3, --lance
	18078, 14400, 3, --spark_lance
	16836, 13500, 3, --halberd
	18122, 13000, 3, --broach_lance
	16901, 16800, 3, --kodachi
	16973, 23000, 3, --homura
	16962, 32500, 3, --ashura
	16970, 32400, 3, --hosodachi
	17045, 22800, 3, --maul
	17052, 8000, 3,  --chestnut_wand
	17061, 8000, 3,  --mythril_rod
	17036, 22600, 3, --mythril_mace
	17080, 31900, 3, --holy_maul
	17097, 8000, 3,  --elm_pole
	17091, 12200, 3, --oak_staff
	17162, 31200, 3, --great_bow
	17155, 12500, 3, --composite_bow
	17218, 17100, 3, --zamburak
	18715, 34000, 3, --marss_hexagun
	18704, 18500, 3, --darksteel_hexagun
	17348, 21000, 3, --traversiere
	17355, 25000, 3, --rose_harp
	15164, 8000, 3,  --garish_crown
	14425, 26500, 3, --garish_tunic
	14857, 8400, 3,  --garish_mitts
	14326, 19000, 3, --garish_slacks
	15314, 12400, 3, --garish_pumps
	15161, 8000, 3,  --noct_beret
	14422, 19800, 3, --noct_doublet
	14854, 13600, 3, --noct_gloves
	14323, 13500, 3, --noct_brais
	15311, 19200, 3, --noct_gaiters
	12610, 17400, 3, --cloak
	12738, 8200, 3,  --linen_mitts
	12866, 18800, 3, --linen_slacks
	12994, 11000, 3, --shoes
	12450, 8500, 3,  --padded_cap
	12578, 39300, 3, --padded_armor
	12706, 21600, 3, --iron_mittens
	12836, 31600, 3, --iron_subligar
	12962, 19600, 3, --leggings
	12466, 12500, 3, --red_cap
	12594, 25000, 3, --gambison
	12722, 8000, 3,  --bracers
	12850, 17500, 3, --hose
	12978, 20000, 3, --socks
	12475, 28500, 3, --velvet_hat
	12603, 42500, 3, --velvet_robe
	12731, 24000, 3, --velvet_cuffs
	12859, 34700, 3, --velvet_slops
	12987, 13400, 3, --ebony_sabots
	13871, 30200, 3, --iron_visor
	13783, 46400, 3, --iron_scale_mail
	14001, 24800, 3, --iron_finger_gauntlets
	14118, 22600, 3, --iron_greaves
	12300, 8000, 3,  --targe
	12293, 19500, 3, --oak_shield
	12364, 25600, 3, --nymph_shield
	
    }

    -- Level 40-50
    local stockE =
    {
 
        16388, 11400, 3, --himantes
	16412, 29800, 3, --mythril_claws
	16419, 41600, 3, --patas
	16459, 37200, 3, --acid_baselard
	17610, 9000, 3,  --bone_knife
	16522, 48000, 3, --flame_degen
	16558, 68000, 3, --falchion
	16564, 77500, 3, --flame_blade
	16567, 77500, 3, --knights_sword
	16590, 67600, 3, --greatsword
	16957, 66900, 3, --faussar
	16657, 66000, 3, --tabar
	16651, 74000, 3, --mythril_pick
	18207, 48100, 3, --kheten
	16775, 69000, 3, --mythril_scythe
	16796, 69800, 3, --mythril_zaghnal
	18050, 101700, 3, --mandibular_sickle
	16847, 25800, 3, --mythril_lance
	16905, 12400, 3, --bokuto
	16902, 23100, 3, --sakurafubuki
	16908, 12000, 3, --yoto
	16915, 23300, 3, --hien
	16967, 37400, 3, --mikazuki
	17062, 11200, 3, --bone_rod
	17053, 13600, 3, --rose_wand
	17098, 15600, 3, --oak_pole
	17523, 10500, 3, --quarterstaff
	17163, 36000, 3, --battle_bow
	17156, 24700, 3, --kaman
	17164, 40800, 3, --war_bow
	17267, 120000, 3, --negoroshiki
	17219, 25500, 3, --arbalest
	18710, 30800, 3, --seadog_gun
	17352, 9000, 3,  --horn
	17350, 12000, 3, --angels_flute
	14243, 41400, 3, --iron_cuisses
	12416, 35400, 3, --sallet
	12544, 54600, 3, --breastplate
	12672, 28800, 3, --gauntlets
	12800, 18000, 3, --cuisses
	12928, 26400, 3, --plate_leggings
	15205, 75000, 3, --alumine_salade
	14444, 162000, 3, --alumine_haubert
	14051, 54000, 3, --alumine_moufles
	15402, 65400, 3, --alumine_brayettes
	15341, 53400, 3, --alumine_sollerets
	12426, 42700, 3, --banded_helm
	12554, 66000, 3, --banded_mail
	12682, 35200, 3, --mufflers
	12810, 52500, 3, --breeches
	12938, 32200, 3, --sollerets
	12444, 22400, 3, --raptor_helm
	12572, 15200, 3, --raptor_jerkin
	12700, 36000, 3, --raptor_gloves
	12828, 21600, 3, --raptor_trousers
	12956, 33600, 3, --raptor_ledelsens
	12417, 43700, 3, --mythril_sallet
	12545, 75000, 3, --mythril_breastplate
	12673, 39600, 3, --mythril_gauntlets
	12801, 35400, 3, --mythril_cuisses
	12929, 36300, 3, --mythril_leggings
	12460, 43700, 3, --shinobi_hachigane
	12588, 66000, 3, --shinobi_gi
	12716, 36300, 3, --shinobi_tekko
	12844, 34600, 3, --shinobi_hakama
	12972, 33800, 3, --shinobi_kyahan
	13873, 44800, 3, --steel_visor
	13785, 68800, 3, --steel_scale_mail
	14003, 36800, 3, --steel_finger_gauntlets
	14245, 58600, 3, --steel_cuisses
	14120, 32500, 3, --steel_greaves
	15242, 21000, 3, --crow_beret
	14498, 30800, 3, --crow_jupon
	14907, 18200, 3, --crow_bracers
	15578, 28700, 3, --crow_hose
	15663, 38500, 3, --crow_gaiters
	12307, 31600, 3, --heater_shield
	12301, 31100, 3, --buckler
	12294, 12800, 3, --leather_shield

    }

   -- Level 51-59
   local stockF =
    {
 
        16394, 38900, 3, --darksteel_knuckles
	16400, 48400, 3, --darksteel_katars
	17612, 20000, 3, --beetle_knife
	16538, 75200, 3, --darksteel_sword
	16554, 101800, 3, --hanger
	16585, 99700, 3, --darksteel_claymore
	16645, 102500, 3, --darksteel_axe
	16794, 20000, 3, --bone_scythe
	16888, 73500, 3, --battle_fork
	16848, 48300, 3, --darksteel_lance
	17236, 62300, 3, --leo_crossbow
	17361, 20000, 3, --crumhorn
	12323, 45600, 3, --scutum
	12311, 20000, 3, --hoplon
	16170, 82500, 3, --wivre_shield
	12302, 47300, 3, --darksteel_buckler

    }
   
    -- Level 60-69
    local stockG =
    {
 
        16422, 36200, 3, --tigerfangs
        16477, 89100, 3, --cermet_kukri
        16514, 30300, 3, --mailbreaker
        16541, 135400, 3, --jagdplaute
        16596, 148500, 3, --flamberge
        16653, 55600, 3, --nadziak
        16730, 115500, 3, --colossal_axe
        16789, 125300, 3, --darksteel_scythe
        18093, 48200, 3, --couse
        16842, 54600, 3, --golden_spear
        16903, 40200, 3, --kabutowari
        16909, 26000, 3, --kororito
        16964, 63200, 3, --zanbato
        16972, 79500, 3, --kazaridachi
        17054, 20000, 3, --ebony_wand
        17056, 28400, 3, --mythic_wand
        17100, 43500, 3, --ebony_pole
        17220, 51700, 3, --heavy_crossbow
        17242, 53300, 3, --velocity_bow
        17849, 20000, 3, --hellish_bugle
        12308, 54000, 3, --darksteel_shield
        12295, 28100, 3, --round_shield
        12303, 40800, 3, --gold_buckler
	12324, 39500, 3, --tower_shield
	12310, 56000, 3, --diamond_shield
	12383, 156000, 3, --generals_shield
        
    }

   -- Level 70+
   local stockH =
    {
 
        16423, 103300, 3, --manoples
	--18782, 30000, 3, --eyra_baghnakhs
	16470, 30000, 3, --gully
	--16485, 68700, 3, --yataghan
	--19138, 68700, 3, --verus_knife
	--17664, 68700, 3, --firmament
	--18901, 85200, 3, --falcata
	19151, 162500, 3, --bahadur
	--19165, 68700, 3, --cratus_sword
	--19170, 86600, 3, --kardia_faussar
	--16660, 69400, 3, --doom_tabar
	--18537, 70100, 3, --maiden_tabar
	16707, 79000, 3, --bhuj
	--18511, 68700, 3, --dolor_bhuj
	--18517, 68700, 3, --elephas_axe
	16777, 67500, 3, --death_scythe
	--18964, 68700, 3, --dire_scythe
	--18555, 76200, 3, --sectum_sickle
	16840, 79500, 3, --ox_tongue
	16861, 30000, 3, --ice_lance
	--19317, 39100, 3, --borian_spear
	18420, 92600, 3, --hayabusa
	--19285, 68700, 3, --kakko
	--19293, 56100, 3, --ichi-an
	--16971, 70100, 3, --yukitsugu
	--16963, 39100, 3, --taimakuniyuki
	18848, 30000, 3, --brass_jadagna
	--18875, 68700, 3, --vodun_mace
	--18877, 30200, 3, --robur_mace
	17102, 30000, 3, --eight-sided_pole
	--18621, 70800, 3, --warmages_pole
	18695, 51600, 3, --cerberus_bow
	--19733, 36100, 3, --beursault_bow
	17252, 80800, 3, --culverin
	17213, 65000, 3, --staurobow
	--19265, 68700, 3, --darkwing
	--19267, 68700, 3, --ribauldequin
	--19735, 65600, 3, --cecchinos_fucile
        17359, 70000, 3, --mythic_harp
        12359, 20400, 3, --hickory_shield
	12309, 64400, 3, --ritter_shield
	12305, 55600, 3, --ice_shield
	12387, 223100, 3, --koenig_shield
	12385, 275500, 3, --acheron_shield
	--16189, 30000, 3, --gleaming_shield
        
    }

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    local pNation = player:getNation()

    if (pNation ~= 2) then
        player:PrintToPlayer( string.format("Please see the Sparks of Eminence representative from your nation."),29 )
        printf("Nation : %i",pNation)
    else	
        player:SetEventNPC(npc:getID())
        player:PrintToPlayer(string.format("Select level range."), 29);
        player:PrintToPlayer(string.format("Level? %s %s %s %s %s %s %s %s",opt1, opt2, opt3, opt4, opt5, opt6, opt7, opt8), 12)
    end
end

function onMenuSelection(player, npc, Choice)
    local ChoiceData = 
    {
	{ choice =   "1-9",         stock = stockA   },
	{ choice = "10-19",         stock = stockB   },
	{ choice = "20-29",         stock = stockC   },
	{ choice = "30-39",         stock = stockD   },
	{ choice = "40-50",         stock = stockE   },
	{ choice = "51-59",         stock = stockF   },
	{ choice = "60-69",         stock = stockG   },
	{ choice =   "70+",         stock = stockH   },
    }

    for _, v in pairs(ChoiceData) do
        if v.choice == Choice then
            player:PrintToPlayer(string.format("Level range: %s", v.choice), 29);
            tpz.shop.nation(player, v.stock, tpz.nation.WINDURST)
        end
    end
end