-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Jamal
-- Type: Job-specific Atma
-- !pos 
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------

local job_map =
{
  [tpz.job.WAR]	= { testimony = 1426,    mod1 = tpz.mod.ACC,        inc1 =   2,    mod2 = tpz.mod.ATT,              inc2 =  2,    mod3 = tpz.mod.DEF,              inc3 =   3  },
  [tpz.job.MNK]	= { testimony = 1427,    mod1 = tpz.mod.ACC,        inc1 =   2,    mod2 = tpz.mod.EVA,              inc2 =  2,    mod3 = tpz.mod.HPP,              inc3 =   2  },
  [tpz.job.WHM]	= { testimony = 1428,    mod1 = tpz.mod.ENMITY,     inc1 =  -3,    mod2 = tpz.mod.CURE_POTENCY,     inc2 =  2,    mod3 = tpz.mod.REGEN,            inc3 =   1  },
  [tpz.job.BLM]	= { testimony = 1429,    mod1 = tpz.mod.ELEM,       inc1 =   3,    mod2 = tpz.mod.ENMITY,           inc2 = -3,    mod3 = tpz.mod.MAGIC_DAMAGE,     inc3 =   1  },
  [tpz.job.RDM]	= { testimony = 1430,    mod1 = tpz.mod.ELEM,       inc1 =   3,    mod2 = tpz.mod.ACC,              inc2 =  1,    mod3 = tpz.mod.MACC,             inc3 =   1  },
  [tpz.job.THF]	= { testimony = 1431,    mod1 = tpz.mod.MEVA,       inc1 =   3,    mod2 = tpz.mod.SNEAK_ATK_DEX,    inc2 =  1,    mod3 = tpz.mod.TRICK_ATK_AGI,    inc3 =   1  },
  [tpz.job.PLD]	= { testimony = 1432,    mod1 = tpz.mod.ENMITY,     inc1 =  50,    mod2 = tpz.mod.DMGPHYS,          inc2 =  1,    mod3 = tpz.mod.ACC,              inc3 =   1  },
  [tpz.job.DRK]	= { testimony = 1433,    mod1 = tpz.mod.ATT,        inc1 =   2,    mod2 = tpz.mod.TP_BONUS,         inc2 =  5,    mod3 = tpz.mod.ENSPELL_DMG_BONUS, inc3 =  1  },
  [tpz.job.BST]	= { testimony = 1434,    mod1 = tpz.mod.ATT,        inc1 =   1,    mod2 = tpz.mod.ATT,              inc2 =  1,    mod3 = tpz.mod.DEF,              inc3 =   1  },
  [tpz.job.BRD]	= { testimony = 1435,    mod1 = tpz.mod.DEF,        inc1 =   3,    mod2 = tpz.mod.ENMITY,           inc2 = -3,    mod3 = tpz.mod.SONG_RECAST_DELAY, inc3 =  1  },
  [tpz.job.RNG]	= { testimony = 1436,    mod1 = tpz.mod.RATT,       inc1 =  3,     mod2 = tpz.mod.ENMITY,           inc2 = -3,    mod3 = tpz.mod.CRITHITRATE,      inc3 =   1  },
  [tpz.job.SAM]	= { testimony = 1437,    mod1 = tpz.mod.SKILLCHAINDMG, inc1 =  1,  mod2 = tpz.mod.TP_BONUS,         inc2 =  5,    mod3 = tpz.mod.DMGPHYS,          inc3 =   1  },
  [tpz.job.NIN]	= { testimony = 1438,    mod1 = tpz.mod.EVA,        inc1 =  2,     mod2 = tpz.mod.ATT,              inc2 =  3,    mod3 = tpz.mod.ACC,              inc3 =   1  },
  [tpz.job.DRG]	= { testimony = 1439,    mod1 = tpz.mod.ACC,        inc1 =  2,     mod2 = tpz.mod.ATT,              inc2 =  2,    mod3 = tpz.mod.JUMP_ATT_BONUS,   inc3 =   1  },
  [tpz.job.SMN]	= { testimony = 1440,    mod1 = tpz.mod.MP,         inc1 =  1,     mod2 = tpz.mod.ATT,              inc2 =  1,    mod3 = tpz.mod.DEF,              inc3 =   1  },
  [tpz.job.BLU]	= { testimony = 2331,    mod1 = tpz.mod.BLUE_POINTS,   inc1 =  1,  mod2 = tpz.mod.ATT,              inc2 =  2,    mod3 = tpz.mod.ACC,              inc3 =   2  },
  [tpz.job.COR]	= { testimony = 2332,    mod1 = tpz.mod.RATT,       inc1 =  2,     mod2 = tpz.mod.RACC,             inc2 =  2,    mod3 = tpz.mod.PHANTOM_DURATION, inc3 =   1  },
  [tpz.job.PUP]	= { testimony = 2333,    mod1 = tpz.mod.ATT,        inc1 =  1,     mod2 = tpz.mod.HP,               inc2 = 50,    mod3 = tpz.mod.MP,               inc3 =  50  },
  [tpz.job.DNC]	= { testimony = 2556,    mod1 = tpz.mod.STORETP,    inc1 =  5,     mod2 = tpz.mod.DEF,              inc2 =  1,    mod3 = tpz.mod.SAMBA_DURATION,   inc3 =   1  },
  [tpz.job.SCH]	= { testimony = 2557,    mod1 = tpz.mod.MPP,        inc1 =  2,     mod2 = tpz.mod.MACC,             inc2 =  1,    mod3 = tpz.mod.MAGIC_DAMAGE,     inc3 =   1  }
}

local opt1  = "Job"
local opt2  = "Attribute1"
local opt3  = "Attribute2"
local opt4  = "Attribute3"

-- invert tpz.zone table
local modNameByNum={}
    for k, v in pairs(tpz.mod) do
        modNameByNum[v]=k
    end

-- invert tpz.job table
local jobNameByNum={}
    for k, v in pairs(tpz.job) do
        jobNameByNum[v]=k
    end

local mJob
local pJobMap

function onTrade(player, npc, trade)
    local targ = player
    local meritCount = targ:getMeritCount()
    mJob = targ:getMainJob()
    local ng_job = 0
    pJobMap = job_map[mJob]
    local hasItem = trade:hasItemQty(pJobMap.testimony, 1)
    local choice = targ:getLocalVar("[atma]npcChoice")

    if (targ:getCharVar("ng_job") ~= nil) then
        ng_job = targ:getCharVar("ng_job")
    end

    if (choice == 0) then
        targ:PrintToPlayer( string.format("Please select an option first."), 14 )
        return
    end
  
    if (not hasItem or trade:getItemCount() > 1) then
        targ:PrintToPlayer( string.format("Please trade only a %s testimony to continue.", jobNameByNum[mJob]), 14 )
        return
    end

    if (meritCount == 40 and mJob == ng_job) then
        if (choice == 99) then
    	    targ:tradeComplete()
            targ:setMerits(0)
            targ:setCharVar("[atma]mod1", pJobMap.mod1) 
	    targ:setCharVar("[atma]mod2", pJobMap.mod2)
            targ:setCharVar("[atma]mod3", pJobMap.mod3)
 	    targ:setCharVar("[atma]val1", 0) 
	    targ:setCharVar("[atma]val2", 0)
            targ:setCharVar("[atma]val3", 0)
            targ:PrintToPlayer( string.format("Completed successfully."), 29 )
        elseif (choice == 1 and targ:getCharVar("[atma]mod1") > 0) then
    	    targ:tradeComplete()
            targ:setMerits(0)
            targ:addCharVar("[atma]val1", pJobMap.inc1) 
	    targ:PrintToPlayer( string.format("Completed successfully."), 29 )
	elseif (choice == 2 and targ:getCharVar("[atma]mod2") > 0) then
    	    targ:tradeComplete()
            targ:setMerits(0)
            targ:addCharVar("[atma]val2", pJobMap.inc2)
	    targ:PrintToPlayer( string.format("Completed successfully."), 29 )   
	elseif (choice == 3 and targ:getCharVar("[atma]mod3") > 0) then
    	    targ:tradeComplete()
            targ:setMerits(0)
            targ:addCharVar("[atma]val3", pJobMap.inc3) 
	    targ:PrintToPlayer( string.format("Completed successfully."), 29 ) 
        else
	    targ:PrintToPlayer( string.format("A Job has not been chosen first to create attributes."), 14 )
        end
    else
	player:PrintToPlayer( string.format("You do not meet one or both of the specified parameters:"), 14 )
        player:PrintToPlayer( string.format("Merits required: 40 | Merits earned: %u", meritCount), 14 )
        player:PrintToPlayer( string.format("Current Job: %s | NG Job: %s", jobNameByNum[mJob], jobNameByNum[ng_job]), 14 )
    end
end

function onTrigger(player,npc)
    mJob = player:getMainJob()
    pJobMap = job_map[mJob]

    player:SetEventNPC(npc:getID())
    player:PrintToPlayer(string.format("Choice? %s %s %s %s",opt1, opt2, opt3, opt4), 12)
    player:PrintToPlayer( string.format("Trade a %s testimony after making a selection.  Cost is 40 merits.", jobNameByNum[mJob]), 29 )
    player:PrintToPlayer( string.format("Choose \"Job\" to set initial modifiers on current job.  This only needs done once and will delete existing attributes."), 29 )
    player:PrintToPlayer( string.format("Choose \"Attribute1\" to add %i to the %s attribute.", pJobMap.inc1, modNameByNum[pJobMap.mod1]), 29 )
    player:PrintToPlayer( string.format("Choose \"Attribute2\" to add %i to the %s attribute.", pJobMap.inc2, modNameByNum[pJobMap.mod2]), 29 )
    player:PrintToPlayer( string.format("Choose \"Attribute3\" to add %i to the %s attribute.", pJobMap.inc3, modNameByNum[pJobMap.mod3]), 29 )
    player:PrintToPlayer( string.format("Pet classes \"Attribute2\" and \"Attribute3\" apply to the pets."), 29 )
end

function onMenuSelection(player, npc, Choice)
    mJob = player:getMainJob()
    pJobMap = job_map[mJob]

local data = 
{
	{ choice = "Job",                  id = 99 },
	{ choice = "Attribute1",           id = 1  },
	{ choice = "Attribute2",           id = 2  },
	{ choice = "Attribute3",           id = 3  },
}

	for _, v in pairs(data) do
		if v.choice == Choice then
			if (v.id == 99) then
				player:setLocalVar("[atma]npcChoice",v.id)
				player:PrintToPlayer( string.format("Trade job testimony to set attributes on current job for 40 merits."), 29 )
				return
			elseif (v.id == 1) then
				player:setLocalVar("[atma]npcChoice",v.id)
				player:PrintToPlayer( string.format("%s will be increased after trading testimony and spending 40 merits.", modNameByNum[pJobMap.mod1]), 29 )
				return
			elseif (v.id == 2) then
				player:setLocalVar("[atma]npcChoice",v.id)
				player:PrintToPlayer( string.format("%s will be increased after trading testimony and spending 40 merits.", modNameByNum[pJobMap.mod2]), 29 )
				return
			elseif (v.id == 3) then
				player:setLocalVar("[atma]npcChoice",v.id)
				player:PrintToPlayer( string.format("%s will be increased after trading testimony and spending 40 merits.", modNameByNum[pJobMap.mod3]), 29 )
				return
			else
				player:PrintToPlayer(("Please try again."), 29)
			end
                end
        end

        if Choice == "Canceled." then
		player:PrintToPlayer(string.format("Selection cancelled."), 29)
	end
end
