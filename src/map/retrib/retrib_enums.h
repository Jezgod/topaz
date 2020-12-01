/**************************************************************************
 Retrib Stats Enumerations and Header File
**************************************************************************/

#ifndef _RETRIB_ENUMS_H
#define _RETRIB_ENUMS_H

namespace Retrib
{
    enum Jobs
    {
        WAR = 1,
        MNK = 2,
        WHM = 3,
        BLM = 4,
        RDM = 5,
        THF = 6,
        PLD = 7,
        DRK = 8,
        BST = 9,
        BRD = 10,
        RNG = 11,
        SAM = 12,
        NIN = 13,
        DRG = 14,
        SMN = 15,
        BLU = 16,
        COR = 17,
        PUP = 18,
        DNC = 19,
        SCH = 20
        //GEO = 21,
        //RUN = 22
    };

    enum Access
    {
        ADOULIN,              // 0
        AREA_ESCHAN,          // 1
        MEMORIAL_LIBRARY,     // 2
        RAKAZNAR,             // 3
        REISENJIMA            // 4
    };
    
    enum Event
    {
        OVERALL,               // 0
        STRONGEST,             // 1
        EASTER,                // 2
        SUMMER,                // 3
        HALLOWEEN,             // 4
        CHRISTMAS,             // 5
        NEWYEAR,               // 6
        BOUNTY                 // 7
    };

    enum Gear
    {
        GEAR_NONE,             // 0
        GEAR_AF1,              // 1
        GEAR_AF2,              // 2
        GEAR_AF1P1,            // 3
        GEAR_AF2P1,            // 4
        GEAR_QUEST,            // 5
        GEAR_MISSION,          // 6
        GEAR_SKY,              // 7
        GEAR_CURSED,           // 8   
        GEAR_SEA,              // 9
        GEAR_LIMBUS,           // 10
        GEAR_ASSAULT,          // 11
        GEAR_SALVAGE,          // 12
        GEAR_ZNM,              // 13
        GEAR_RELIC,            // 14
        GEAR_MYTHIC,           // 15
        GEAR_DROP_MINOR,       // 16
        GEAR_DROP_MAJOR,       // 17
        GEAR_NM_MISC           // 18 
    };
    
	enum GearPoints
	{
        GP_NONE       =    0,  // 0
        GP_AF1        =   75,  // 1
        GP_AF2        =  150,  // 2
        GP_AF1P1      =  200,  // 3
        GP_AF2P1      =  250,  // 4
        GP_QUEST      = 5000,  // 5
        GP_MISSION    = 1250,  // 6
        GP_SKY        = 2500,  // 7
        GP_CURSED     =  550,  // 8     
        GP_SEA        =  550,  // 9
        GP_LIMBUS     = 3000,  // 10
        GP_ASSAULT    =  650,  // 11
        GP_SALVAGE    = 3500,  // 12
        GP_ZNM        = 1500,  // 13
        GP_RELIC      = 5000,  // 14
        GP_MYTHIC     = 5000,  // 15
        GP_DROP_MINOR =  250,  // 16
        GP_DROP_MAJOR = 3500,  // 17
        GP_NM_MISC    =  100   // 18
    };

    enum Stat
    {
        STAT_WEAPONSKILL,       // 0
        STAT_DEATH,             // 1
        STAT_MOB_KILL,          // 2
        STAT_NM_KILL,           // 3
        STAT_BATTLEFIELD,       // 4
        STAT_NQ_SYNTH,          // 5
        STAT_HQ_SYNTH,          // 6
        STAT_ENHANCEMENT,       // 7
        STAT_MINING,            // 8
        STAT_LOGGING,           // 9
        STAT_HARVESTING,        // 10
        STAT_EXCAVATING,        // 11
        STAT_FISHING,           // 12
        STAT_DIGGING,           // 13
        STAT_SPELL,             // 14
        STAT_SUPPLY,            // 15
        STAT_QUEST,             // 16
        STAT_MISSION,           // 17
        STAT_VALOR,             // 18
        STAT_PVP,               // 19
        STAT_JOBTO75,           // 20
        STAT_CRAFTTO100,        // 21
        STAT_AREA,              // 22
        STAT_SKILL,             // 23
        STAT_GEAR,              // 24
        STAT_EXPERIENCE         // 25
    };

    enum StatPoints
    {
	SP_WEAPONSKILL =    1,  // Weapon Skill			    [ 0]  charutils::OnWeaponskillFinished
	SP_DEATH       =  100,  // Death			        [ 1]  CCharEntity::Die() NEGATIVE RESULT (DelStat)
	SP_BATTLEFIELD =  150,  // BCNM				        [ 4]  CBattlefield::Cleanup()
	SP_NQ_SYNTH    =    1,  // NQ Synth			        [ 5]  SynthUtils->doSynthResult
	SP_HQ_SYNTH    =    5,  // HQ Synth			        [ 6]  SynthUtils->doSynthResult
	SP_ENHANCEMENT =   10,  // Enhancement			    [ 7]  Synergy_Furnace.lua
	SP_MINING      =    1,  // Mining			        [ 8]  Helm.lua->onTrade
	SP_LOGGING     =    1,  // Logging			        [ 9]  Helm.lua->onTrade
	SP_HARVESTING  =    1,  // Harvesting			    [10]  Helm.lua->onTrade
	SP_EXCAVATING  =    1,  // Excavating 		        [11]  Helm.lua->onTrade
	SP_FISHING     =    1,  // Fishing			        [12]  fishingutils.cpp->FishingAction
	SP_DIGGING     =    1,  // Digging			        [13]  chocobodigging.lua->updatePlayerDigCount   ADD!!!!!!!!!!!
	SP_SPELL       =   15,  // Learned Spell		    [14]  charutils->AddSpell
    SP_SUPPLY      =   15,  // Supply Quest			    [15]  conquest.lua dsp.conquest.overseerOnEventFinish   ADD!!!!!!!!!!!
	SP_QUEST       =   25,  // Quest			        [16]  LuaBaseEntity->completeQuest
	SP_MISSION     =  250,  // Mission			        [17]  LuaBaseEntity->completeMission
    SP_VALOR       =   50,  // Valor Points             [18]  regimes.lua->checkRegime
    SP_PVP         = 1000,  // PVP Points               [19]  CCharEntity::Die() 
	SP_JOBTO75     = 2500,  // Job to 75			    [20]  charutils::AddExperiencePoints->LevelUp
	SP_CRAFTTO100  = 2500,  // Craft to 100			    [21]  SynthUtils->doSynthSkillUp
    SP_AREA        =   20,  // Areas Found     	        [22]  ZoneUtils->LoadChar (Only for SA)
    SP_CRAFT       =    1,  // Craft Skillups           [  ]  Synthutils->doSynthSkillUp (Bit Shift for SA)
    SP_EXPERIENCE  =    3   // Experience Multiplier    [25]  Charutils->AddExperiencePoints (Bit Shift for SA) 
    };
 
}; // Namespace Retrib

#endif // _RETRIB_H
