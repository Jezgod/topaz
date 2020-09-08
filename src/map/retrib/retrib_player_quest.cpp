/**************************************************************************
 Retrib Class Quest Methods
**************************************************************************/ 

#include "../utils/charutils.h"
#include "retrib_player_quest.h"

CRetribPlayerQuest::CRetribPlayerQuest(uint16 ID)
{
    this->ID = ID;
	memset(&Quests,  0, sizeof(Quests));
    memset(&Repeats, 0, sizeof(Repeats));
}
CRetribPlayerQuest::~CRetribPlayerQuest()
{
}

auto CRetribPlayerQuest::SaveQuests() -> void
{
    const char* Query = "UPDATE retrib_pc SET Quests = '%s' WHERE ID = %u;";
    char Buffer[sizeof(Quests) * 2 + 1];
    Sql_EscapeStringLen(SqlHandle, Buffer, (const char*)Quests, sizeof(Quests));
    Sql_Query(SqlHandle, Query, Buffer, ID);
}

auto CRetribPlayerQuest::SaveRepeats() -> void
{
    const char* Query = "UPDATE retrib_pc SET Repeats = '%s' WHERE ID = %u;";
    char Buffer[sizeof(Repeats) * 2 + 1];
    Sql_EscapeStringLen(SqlHandle, Buffer, (const char*)Repeats, sizeof(Repeats));
    Sql_Query(SqlHandle, Query, Buffer, this->ID);
}

auto CRetribPlayerQuest::Add(uint8 QID, uint8 RID) -> void
{
    Quests[QID].Status = 1;
    Quests[QID].RepeatLink = RID;
    SaveQuests();
}

auto CRetribPlayerQuest::Complete (uint8 QID) -> void
{
    Quests[QID].Completed = 1;
    
    uint8 RID = Quests[QID].RepeatLink;
    if (RID)
    {
        Repeats[RID].Tally++;
        SaveRepeats();
    }
    SaveQuests();
}

auto CRetribPlayerQuest::Delete (uint8 QID) -> void
{
    uint8 RID = Quests[QID].RepeatLink;
    memset(&Quests[QID], 0, sizeof(Quests[QID]));
    if (RID)
    {
        memset(&Repeats[RID], 0, sizeof(Repeats[RID]));
        SaveRepeats();
    }
    SaveQuests();
}

auto CRetribPlayerQuest::HasCompleted (uint8 QID) -> bool
{
	return Quests[QID].Completed == 1;
}

auto CRetribPlayerQuest::GetStatus (uint8 QID) -> uint8
{
	return Quests[QID].Status;
}

auto CRetribPlayerQuest::SetStatus (uint8 QID, uint8 Status) -> void
{
	this->Quests[QID].Status = Status;
    SaveQuests();
}

auto CRetribPlayerQuest::AddStatus (uint8 QID) -> void
{
	Quests[QID].Status += 1;
    SaveQuests();
}

auto CRetribPlayerQuest::GetTimer (uint8 QID) -> uint32
{
	return Quests[QID].Timer;
}

auto CRetribPlayerQuest::SetTimer (uint8 QID, uint32 Timer) -> void
{
	this->Quests[QID].Timer = Timer;
    SaveQuests();
}

auto CRetribPlayerQuest::GetOption (uint8 QID, uint8 O) -> uint32
{
	return Quests[QID].Option[O];
}
auto CRetribPlayerQuest::SetOption (uint8 QID, uint8 O, uint32 Value) -> void
{
    Quests[QID].Option[O] = Value;
    SaveQuests();
}

auto CRetribPlayerQuest::GetTally (uint8 QID) -> uint16
{
    uint8 Index = Quests[QID].RepeatLink;
	return Repeats[Index].Tally;
}

auto CRetribPlayerQuest::SetTally (uint8 QID, uint16 Tally) -> void
{
    uint8 Index = Quests[QID].RepeatLink;
    Repeats[Index].Tally = Tally;
    SaveRepeats();
}

auto CRetribPlayerQuest::AddTally (uint8 QID, uint8 Amount) -> void
{
    uint8 Index = Quests[QID].RepeatLink;
	Repeats[Index].Tally += Amount ? Amount : 1;
    SaveRepeats();
}

auto CRetribPlayerQuest::GetXP (uint8 QID) -> uint16
{
    uint8 Index = Quests[QID].RepeatLink;
	return Repeats[Index].XP;
}

auto CRetribPlayerQuest::SetXP (uint8 QID, uint16 XP) -> void
{
    uint8 Index = Quests[QID].RepeatLink;
	Repeats[Index].XP = XP;
    SaveRepeats();
}

auto CRetribPlayerQuest::GetGil (uint8 QID) -> uint32
{
    uint8 Index = Quests[QID].RepeatLink;
	return Repeats[Index].Gil;
}

auto CRetribPlayerQuest::SetGil (uint8 QID, uint32 Gil) -> void
{
    uint8 Index = Quests[QID].RepeatLink;
	Repeats[Index].Gil = Gil;
    SaveRepeats();
}

auto CRetribPlayerQuest::GetItem (uint8 QID) -> uint16
{
    uint8 Index = Quests[QID].RepeatLink;
	return Repeats[Index].Item;
}

auto CRetribPlayerQuest::SetItem (uint8 QID, uint16 Item) -> void
{
    uint8 Index = Quests[QID].RepeatLink;
	Repeats[Index].Item = Item;
    SaveRepeats();
}

auto CRetribPlayerQuest::GetQty (uint8 QID) -> uint16
{
    uint8 Index = Quests[QID].RepeatLink;
	return Repeats[Index].Qty;
}

auto CRetribPlayerQuest::SetQty (uint8 QID, uint16 Qty) -> void
{
    uint8 Index = Quests[QID].RepeatLink;
	Repeats[Index].Qty = Qty;
    SaveRepeats();
}