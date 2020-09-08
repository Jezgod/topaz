/**************************************************************************
 Retrib Class Quest Header File
**************************************************************************/

#ifndef _RETRIB_PLAYER_QUEST_H
#define _RETRIB_PLAYER_QUEST_H

struct Quest_t
{
	uint8  Completed  = 0;
    uint8  Status     = 0;
	uint32 Timer      = 0;
	uint32 Option[4]  = {0,0,0,0};
    uint8  RepeatLink = 0;
};

struct Repeatable_t
{
	uint32 Tally = 0;
    uint16 XP    = 0;
    uint32 Gil   = 0;
    uint16 Item  = 0;
	uint16 Qty   = 0;
};

class CRetribPlayerQuest
{
    public:

    CRetribPlayerQuest(uint16);
    ~CRetribPlayerQuest();

    uint16 ID;
    Quest_t Quests[80];			      // Active Retrib Quest Data
    Repeatable_t Repeats[15];		  // Repeatable Retrib Quest Data

    auto SaveQuests   (void)                    -> void;
    auto SaveRepeats  (void)                    -> void;

    auto Add          (uint8, uint8)            -> void;
    auto Complete     (uint8)                   -> void;
    auto Delete       (uint8)                   -> void;
    auto HasCompleted (uint8)                   -> bool;

    auto GetStatus    (uint8)                   -> uint8;
    auto SetStatus    (uint8, uint8)            -> void;
    auto AddStatus    (uint8)                   -> void;

    auto GetTimer     (uint8)                   -> uint32;
    auto SetTimer     (uint8, uint32)           -> void;

    auto GetOption    (uint8, uint8)            -> uint32;
    auto SetOption    (uint8, uint8, uint32)    -> void;

    auto GetTally     (uint8)                   -> uint16;
    auto SetTally     (uint8, uint16)           -> void;
    auto AddTally     (uint8, uint8)            -> void;

    auto GetXP        (uint8)                   -> uint16;
    auto SetXP        (uint8, uint16)           -> void;

    auto GetGil       (uint8)                   -> uint32;
    auto SetGil       (uint8, uint32)           -> void;

    auto GetItem      (uint8)                   -> uint16;
    auto SetItem      (uint8, uint16)           -> void;

    auto GetQty       (uint8)                   -> uint16;
    auto SetQty       (uint8, uint16)           -> void;
};

#endif // _RETRIB_PLAYER_QUEST_H