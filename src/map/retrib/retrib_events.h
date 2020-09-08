/**************************************************************************
 Retrib Event Class Header
**************************************************************************/

#ifndef _RETRIB_EVENTS_H
#define _RETRIB_EVENTS_H

#include "../../common/cbasetypes.h"
#include "../../common/mmo.h"
#include "../utils/charutils.h"
#include "retrib_enums.h"

class CStrongest
{
    public:

    CStrongest();
    ~CStrongest();
    
    auto ClearData(bool)                             -> void;
    auto LoadData()                                  -> void;
    auto SaveData()                                  -> void;
    auto UpdateData(uint8)                           -> void;
    auto Start()                                     -> void;
    auto NewDay()                                    -> void;
    auto Finish()                                    -> void;    

    auto SetTask()                                   -> void;
    auto GetTask()                                   -> uint8;
    auto GetTask(std::string &T)                     -> void;
    auto SetRewards(uint8)                           -> void;
    auto GetRewards(std::vector<std::string> &Items) -> void;
    auto GiveRewards(uint8)                          -> void;
    auto SendAnnouncement(CCharEntity*, uint8)       -> void;
    
    auto GetRankings(std::string[], uint32[], uint16, bool)    -> uint32;
    auto GetTotalPoints(uint16, bool)                           ->uint32;
    
    auto AddPoints(uint16, uint16)                   -> void;
    auto DelPoints(uint16, uint16)                   -> void;
    auto ResetPoints()                               -> void;
    auto RegisterSA(uint16, const char*)             -> void;
    auto IsActive()                                  -> bool;

    private:

    bool   Active;
    uint8  Task;
    uint8  Index;
    uint8  Gil;

    uint16 Rewards[5];
    std::string RewardText[4];
    uint16 Winners[4];
    std::string WinNames[4];
};

class CRetribEvent
{
    public:

    CRetribEvent();
    ~CRetribEvent();
    
    CStrongest* SA = nullptr;

    auto InitializeEvents(void) -> void;
    auto DailyGiftUpdate(void)  -> void;
};

#endif // _RETRIB_EVENTS_H