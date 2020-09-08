/**************************************************************************
 Retrib Header File
**************************************************************************/

#ifndef _RETRIB_PLAYER_EVENT_H
#define _RETRIB_PLAYER_EVENT_H

#include "../entities/charentity.h"
#include <set>

class CRetribPlayerEvent
{
    public:

    CRetribPlayerEvent(uint16 ID);
    ~CRetribPlayerEvent();

    uint16 ID;
    bool    HasGift;           // If character has received the daily login award;
    uint8   GiftDay;

    auto GetEventNPC            (void)           -> uint32;
    auto SetEventNPC            (uint32)         -> void;

    auto GetRankings            (std::string [], uint32[]) -> uint32;
    auto GetTotalPoints         (uint16)                    ->uint32;
    auto GetBounty              (std::string []) -> uint16;
    auto GetBountyPoints        (std::string []) -> uint16;

    auto HasDailyGift           (void)           -> bool;
    auto ResetDailyGift         (void)           -> void;
    auto GiveDailyGift          (void)           -> void;
    auto SetDailyGiftDay        (uint8)          -> void;
    auto GetDailyGiftDay        (void)           -> uint8;

    auto HasVisitedArea         (uint16, uint16) -> bool;
    auto AddArea                (uint16, uint16) -> void;
    auto HasGear                (uint8, uint16)  -> bool;
    auto AddGear                (uint8, uint16)  -> void;

    private:

    uint32  EventNPC;		   // Holds a temporary NCP ID used for menu selections and other events
    std::set<uint16> Area[46]; // Temp areas the player has visited for SA Event
    std::set<uint16> Gear[20]; // Temp holds gear player has obtained during SA Event
};

#endif // _RETRIB_PLAYER_EVENT_H
