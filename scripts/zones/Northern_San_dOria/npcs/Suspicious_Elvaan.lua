-----------------------------------
--  Area: Northern San d'Oria
--  NPC: Suspicious Elvaan
--  Working 100%
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/settings");
-----------------------------------

local job_map =
{
    	[tpz.job.MNK]	= 	{relic = { name = "SPHARAI",      lv75 = 18264,  lv80 = 18265, lv85 = 18637, lv90 = 18651, lv95 = 18665, lv99I = 19746, lv99II = 19839, lv119I = 20480, lv119II = 20481, lv119III = 20509, cost = 1000000 }},
	[tpz.job.RDM]	=	{relic = { name = "EXCALIBUR",    lv75 = 18276,  lv80 = 18277, lv85 = 18639, lv90 = 18653, lv95 = 18667, lv99I = 19748, lv99II = 19841, lv119I = 20645, lv119II = 20646, lv119III = 20685, cost = 1000000 }},
	[tpz.job.PLD]	=	{relic = { name = "EXCALIBUR",    lv75 = 18276,  lv80 = 18277, lv85 = 18639, lv90 = 18653, lv95 = 18667, lv99I = 19748, lv99II = 19841, lv119I = 20645, lv119II = 20646, lv119III = 20685, cost = 1000000 }},
	[tpz.job.WAR]	=	{relic = { name = "BRAVURA",      lv75 = 18294,  lv80 = 18295, lv85 = 18642, lv90 = 18656, lv95 = 18670, lv99I = 19751, lv99II = 19844, lv119I = 20835, lv119II = 20836, lv119III = 21756, cost = 1000000 }},
        [tpz.job.DRK]	=	{relic = { name = "APOCALYPSE",   lv75 = 18306,  lv80 = 18307, lv85 = 18644, lv90 = 18658, lv95 = 18672, lv99I = 19753, lv99II = 19846, lv119I = 20880, lv119II = 20881, lv119III = 21808, cost = 1000000 }},
        [tpz.job.NIN]	=	{relic = { name = "KIKOKU",       lv75 = 18312,  lv80 = 18313, lv85 = 18645, lv90 = 18659, lv95 = 18673, lv99I = 19754, lv99II = 19847, lv119I = 20970, lv119II = 20971, lv119III = 21906, cost = 1000000 }},
	[tpz.job.WHM]	=	{relic = { name = "MJOLLNIR",     lv75 = 18324,  lv80 = 18325, lv85 = 18647, lv90 = 18661, lv95 = 18675, lv99I = 19756, lv99II = 19849, lv119I = 21060, lv119II = 21061, lv119III = 21077, cost = 1000000 }},
	[tpz.job.RNG]	=	{relic = { name = "YOICHINOYUMI", lv75 = 18348,  lv80 = 18349, lv85 = 18650, lv90 = 18664, lv95 = 18678, lv99I = 19759, lv99II = 19852, lv119I = 21210, lv119II = 21211, lv119III = 22115, cost = 1000000 }},
	[tpz.job.SAM]	=	{relic = { name = "YOICHINOYUMI", lv75 = 18348,  lv80 = 18349, lv85 = 18650, lv90 = 18664, lv95 = 18678, lv99I = 19759, lv99II = 19852, lv119I = 21210, lv119II = 21211, lv119III = 22115, cost = 1000000 }},
	[tpz.job.BRD]	=	{relic = { name = "GJALLAHORN",   lv75 = 18342,  lv80 = 18572, lv85 = 18577, lv90 = 18578, lv95 = 18579, lv99I = 18580, lv99II = 18840, lv119I = 0, lv119II = 0, lv119III = 0, cost = 1000000 }},
}

function onTrade(player,npc,trade)
	local pLevel = player:getMainLvl()
	local mJob = player:getMainJob()
	local pJobMap = job_map[mJob]
	--local hasBase = trade:hasItemQty(pJobMap.relic.base, 1)
        local has75 = player:hasItem(pJobMap.relic.lv75)
        local has80 = player:hasItem(pJobMap.relic.lv80)
        local has85 = player:hasItem(pJobMap.relic.lv85)
	local has90 = player:hasItem(pJobMap.relic.lv90)
	local has95 = player:hasItem(pJobMap.relic.lv95)
	local has99I = player:hasItem(pJobMap.relic.lv99I)
	local has99II = player:hasItem(pJobMap.relic.lv99II)
	local has119I = player:hasItem(pJobMap.relic.lv119I)
	local has119II = player:hasItem(pJobMap.relic.lv119II)
	local has119III = player:hasItem(pJobMap.relic.lv119III)
	local pCP = player:getCP()
	local rCP = pJobMap.relic.cost
	local item = pJobMap.relic.lv75
        local name = pJobMap.relic.name


	if (pLevel < 75) then
  	    player:PrintToPlayer("Relics require Level 75 to obtain.", 29)
            return 1
        end

	if has119III or (mJob == tpz.job.BRD and player:hasItem(18840)) then
	    player:PrintToPlayer(string.format("This Relic cannot be upgraded further."), 29)
	    return 1
	end

	if has75 then
	    rCP = rCP * 2
	    tradeitem = pJobMap.relic.lv75
	    item = pJobMap.relic.lv80
	elseif has80 then
	    rCP = rCP * 3
	    tradeitem = pJobMap.relic.lv80
            item = pJobMap.relic.lv85
        elseif has85 then
	    rCP = rCP * 4
	    tradeitem = pJobMap.relic.lv85
            item = pJobMap.relic.lv90
	elseif has90 then
	    rCP = rCP * 5
	    tradeitem = pJobMap.relic.lv90
            item = pJobMap.relic.lv95
	elseif has95 then
	    rCP = rCP * 6
	    tradeitem = pJobMap.relic.lv95
            item = pJobMap.relic.lv99I
	elseif has99I then
	    rCP = rCP * 7
	    tradeitem = pJobMap.relic.lv99I
            item = pJobMap.relic.lv99II
	elseif has99II then
	    rCP = rCP * 8
	    tradeitem = pJobMap.relic.lv99II
            item = pJobMap.relic.lv119I
	elseif has119I then
	    rCP = rCP * 9
	    tradeitem = pJobMap.relic.lv119I
            item = pJobMap.relic.lv119II
	elseif has119II then
	    rCP = rCP * 10
	    tradeitem = pJobMap.relic.lv119II
            item = pJobMap.relic.lv119III
	end

        if (pCP < rCP) then
  	        player:PrintToPlayer(string.format("This Relic requires %u Conquest Points to obtain.", rCP), 29)
                player:PrintToPlayer(string.format("You currently possess %u.", pCP), 29)
                return 1
        end
  
        if (not has75 and
            trade:getGil() == rCP and
            trade:getItemCount() == 1) then

            player:tradeComplete()
            player:addItem(item)
            player:delCP(rCP)
            player:PrintToPlayer(string.format("Congratulations, you have just earned the %s Relic.", name), 29)
            player:messageSpecial(ID.text.ITEM_OBTAINED,item)

	elseif (trade:getGil() == rCP and
            trade:hasItemQty(tradeitem, 1) and
            trade:getItemCount() == 2) then

	    player:tradeComplete()
            player:addItem(item)
            player:delCP(rCP)
            player:PrintToPlayer(string.format("Congratulations, you have just earned the %s Relic.", name), 29)
            player:messageSpecial(ID.text.ITEM_OBTAINED,item)
        else
            player:PrintToPlayer("Please trade the appropriate items for your desired Relic.", 29)
        end
end

function onTrigger(player,npc)
	player:PrintToPlayer( string.format("Obtain certain Relics here."), 29)
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;