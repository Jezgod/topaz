/**************************************************************************
 Retrib Header File
**************************************************************************/

#ifndef _RETRIB_PLAYER_H
#define _RETRIB_PLAYER_H

#include "../entities/charentity.h"
#include "retrib_player_event.h"
#include "retrib_player_hunter.h"
#include "retrib_player_quest.h"
#include "retrib_player_synergy.h"
#include <set>

struct Coordinates
{
	float  X = 0.0f;
	float  Y = 0.0f;
	float  Z = 0.0f;
	uint8  R = 0;
	uint16 A = 0;
};

class CCharEntity;
class CRetribPlayerEvent;
class CRetribPlayerHunter;
class CRetribPlayerQuest;
class CRetribPlayerSynergy;

class CRetribPlayer
{
    public:

    CRetribPlayer(CCharEntity* PC);
    ~CRetribPlayer();

    CCharEntity* PC                  = nullptr;          // Pointer to Character Entity this object belongs to 
    CRetribPlayerEvent*   Event      = nullptr;
    CRetribPlayerHunter*  Hunter     = nullptr;
    CRetribPlayerQuest*   Quest      = nullptr;
    CRetribPlayerSynergy* Synergy    = nullptr;
    
    uint16                      ID;                 // PChar->ID
    bool                        Aggro;              // If player is currently engaged
    uint32                      JobsTo75;	 		// Jobs in which characters have reached 75
    uint8                       Areas;              // Areas the player has access to
    uint32		  		       	Stats[22];      	// Retrib character stats
    std::set<uint16>            Gear[20];           // Holds gear that the player has previously obtained
    uint8        			    AHP[23];	        // GID,YUG,PAL,QUF,STA,STB,MIS,FEY,RNG,ATT,QCK,TER,CAS,IFR,DEN,TOR,BOY,TOW,PSO,NEW,SKY,SEA,TOA
    Coordinates			        LastPosition;   	// Last coordinates before a warp  
    bool                        IsHunter;           // If player is authorized to hunt NM's
    bool                        MessageAuthority;   // If player can temporarily send a GM message (Synergy Jail)

    auto Initialize             (uint16)        -> void;
    auto RegisterHunter         (void)          -> void;
    
    auto GetID                  (void)          -> uint16;

	auto HasMessageAuthority    (void)          -> bool;
    auto SetMessageAuthority    (bool)          -> void;

    auto GetStat                (uint8)         -> uint16;
    auto AddStat                (uint8, int16)  -> void;
    auto AddStatPVP             (uint8, int16)  -> void;
    auto DelStat                (uint8, int16)  -> void;
    auto ObtainGear             (uint8, uint16) -> void;
    auto CalculatePoints        (void)          -> void;   
    auto HasJobTo75             (uint8)         -> bool;
    auto SetJobTo75             (uint8)         -> void;

	auto HasAggro               (void)          -> bool;
    auto SetAggro               (bool)          -> void;
    auto CanWarp                (void)          -> bool;
    auto AddArea                (uint8)         -> void;
    auto CanAccessArea          (uint8)         -> bool;
    auto GetLastPosition        (void)          -> Coordinates;
    auto SetLastPosition        (Coordinates&)  -> void;
    auto SendToLastPosition     (void)          -> bool;
    auto SendToMoghouse         (void)          -> void;

    auto SaveRetribHomepoints      (void)          -> void;
    auto GetRetribHPStage          (uint8)         -> uint8;
    auto AddRetribHPStage          (uint8)         -> void;
    auto AddRetribHomepoint        (uint8)         -> void;
    auto DelRetribHomepoint        (uint8)         -> void;
    auto HasRetribHomepoint        (uint8)         -> bool;
    auto GetRetribHomepointCount   (void)          -> uint8;
};

#endif // _RETRIB_PLAYER_H