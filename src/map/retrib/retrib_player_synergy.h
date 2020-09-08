/**************************************************************************
 Retrib Synergy Class Header
**************************************************************************/

#ifndef _RETRIB_PLAYER_SYNERGY_H
#define _RETRIB_PLAYER_SYNERGY_H

#include "../../common/cbasetypes.h"
#include "../../common/mmo.h"

class CSynergySession
{
    public:

    CSynergySession();
    ~CSynergySession();
    
    auto IsReady(void)           -> bool;
    auto SetReady(bool)          -> void;
    auto GetConsult(void)        -> uint8;
    auto SetConsult(uint8)       -> void;
    auto GetTier(void)           -> uint8;
    auto SetTier(uint8)          -> void;
    auto GetItem(void)           -> uint16;
    auto SetItem(uint16)         -> void;
    auto GetGil(void)            -> uint32;
    auto SetGil(uint32)          -> void;
    auto GetOption(uint8)        -> uint8;
    auto SetOption(uint8, uint8) -> void;
    
    auto GetNPC(void)            -> uint32;
    auto SetNPC(uint32)          -> void;
    
    auto Clear(void)             -> void;
    
    protected:
    
    uint32  NPC;
    bool	Ready;
	uint8	Consult;
	uint8	Tier;
	uint16	Item;
	uint32	Gil;
	uint8	O1;
	uint8	O2;
	uint8	O3;
	uint8	O4;
};

class CRetribPlayerSynergy
{
    public:

    CRetribPlayerSynergy(uint16);
    ~CRetribPlayerSynergy();

    CSynergySession* Session = nullptr;
    
    auto GetSkill(uint8)           -> uint16;
    auto AddSkill(uint8)           -> void;
    auto SetSkill(uint8, uint16)   -> void;
    
    auto GetTier(void)             -> uint8;
    auto SetTier(uint8)            -> void;
    auto AddTier(void)             -> void;    

    auto GetItems(uint8)           -> uint16;
    auto AddItems(uint8, uint8)    -> void;
    auto SetItems(uint8, uint16)   -> void;
    auto DelItems(uint8, uint8)    -> void;

    auto IsInJail(void)            -> bool;
    auto SetJail(bool)             -> void;

    private:

    uint16    ID;
    uint32	  Skill [10];	// How many enhancements a character has completed per tier
	uint32    Items [10];	// How many ehnancement items a character has stored
	uint8	  Tier;		    // Current synergy tier (aka status in quest)
	bool	  Jail;		    // Is the character in jail because of enhancement quest?  
};

#endif // _RETRIB_PLAYER_SYNERGY_H