/**************************************************************************
 Retrib Player Class
**************************************************************************/
#include "../utils/charutils.h"
#include "../utils/zoneutils.h"
#include "../ai/ai_container.h"
#include "retrib_enums.h"
#include "retrib_player.h"
#include "retrib_events.h"

extern CRetribEvent* ServerEvent;

uint16 GearPoints[20] = 
{
    Retrib::GearPoints::GP_NONE,
    Retrib::GearPoints::GP_AF1,
    Retrib::GearPoints::GP_AF2,
    Retrib::GearPoints::GP_AF1P1,
    Retrib::GearPoints::GP_AF2P1,
    Retrib::GearPoints::GP_QUEST,
    Retrib::GearPoints::GP_MISSION,
    Retrib::GearPoints::GP_SKY,
    Retrib::GearPoints::GP_CURSED,
    Retrib::GearPoints::GP_SEA,
    Retrib::GearPoints::GP_LIMBUS,
    Retrib::GearPoints::GP_ASSAULT,
    Retrib::GearPoints::GP_SALVAGE,
    Retrib::GearPoints::GP_ZNM,
    Retrib::GearPoints::GP_RELIC,
    Retrib::GearPoints::GP_MYTHIC,
    Retrib::GearPoints::GP_DROP_MINOR,
    Retrib::GearPoints::GP_DROP_MAJOR,
    Retrib::GearPoints::GP_NM_MISC
};

int16 StatPoints[20] = 
{
    Retrib::StatPoints::SP_WEAPONSKILL,
    Retrib::StatPoints::SP_DEATH,
    Retrib::StatPoints::SP_BATTLEFIELD,
    Retrib::StatPoints::SP_NQ_SYNTH,
    Retrib::StatPoints::SP_HQ_SYNTH,
    Retrib::StatPoints::SP_ENHANCEMENT,
    Retrib::StatPoints::SP_MINING,
    Retrib::StatPoints::SP_LOGGING,
    Retrib::StatPoints::SP_HARVESTING,
    Retrib::StatPoints::SP_EXCAVATING,
    Retrib::StatPoints::SP_FISHING,
    Retrib::StatPoints::SP_DIGGING,
    Retrib::StatPoints::SP_SPELL,
    Retrib::StatPoints::SP_SUPPLY,
    Retrib::StatPoints::SP_QUEST,
    Retrib::StatPoints::SP_MISSION,
    Retrib::StatPoints::SP_VALOR,
    Retrib::StatPoints::SP_JOBTO75,
    Retrib::StatPoints::SP_CRAFTTO100
};

const char* StatColumn [22] = 
{
    "WS",             // 0
    "DTH",            // 1
    "MOB",            // 2
    "NM",             // 3
    "BCNM",           // 4
    "NQ",             // 5
    "HQ",             // 6
    "ENH",            // 7
    "MIN",            // 8
    "LOG",            // 9
    "HAR",            // 10
    "EXC",            // 11
    "FSH",            // 12
    "DIG",            // 13
    "SPL",            // 14
    "SUP",            // 15
    "QST",            // 16
    "MSN",            // 17
    "VLR",            // 18
    "PVP",            // 19
    "J75",            // 20
    "CFT"             // 21
};

CRetribPlayer::CRetribPlayer(CCharEntity* PChar)
{
    PC = PChar;

    ID = 0;
    Areas = 0;
    JobsTo75 = 0;
    Aggro = false;
    IsHunter = false;
    MessageAuthority = false;
	memset(&AHP,   0, sizeof(AHP));
	memset(&Stats, 0, sizeof(Stats));
}

CRetribPlayer::~CRetribPlayer()
{
    delete Event;
    delete Hunter;
    delete Quest;
    delete Synergy;
}

auto CRetribPlayer::GetID(void) -> uint16
{
    return ID;
}

auto CRetribPlayer::Initialize(uint16 ID) -> void
{
    this->ID      = ID;

    this->Event   = new CRetribPlayerEvent(ID);
    this->Hunter  = new CRetribPlayerHunter(ID);
    this->Quest   = new CRetribPlayerQuest(ID);
    this->Synergy = new CRetribPlayerSynergy(ID);

    // Load Data into Retrib Object
    const char* Query  = 
        "SELECT "
            "A.JT75, "           // 0
            "A.Areas, "          // 1
            //"A.Gear, "           // 2
            "A.Quests, "         // 3
            "A.Repeats, "        // 4
            "A.Hunter, "         // 5
            "A.AHP, "            // 6
            "A.X, "              // 7
            "A.Y, "              // 8
            "A.Z, "              // 9
            "A.R, "              // 10
            "A.A, "              // 11
            "B.WS, "             // 12
            "B.DTH, "            // 13
            "B.MOB, "            // 14
            "B.NM, "             // 15
            "B.BCNM, "           // 16
            "B.NQ, "             // 17
            "B.HQ, "             // 18
            "B.ENH, "            // 19
            "B.MIN, "            // 20
            "B.LOG, "            // 21
            "B.HAR, "            // 22
            "B.EXC, "            // 23
            "B.FSH, "            // 24
            "B.DIG, "            // 25
            "B.SPL, "            // 26
            "B.SUP, "            // 27
            "B.QST, "            // 28
            "B.MSN, "            // 29
            "B.VLR, "            // 30
            "B.PVP, "            // 31
            "B.J75, "            // 32
            "B.CFT, "            // 33
            "C.S0, "             // 34
            "C.S1, "             // 35
            "C.S2, "             // 36
            "C.S3, "             // 37
            "C.S4, "             // 38
            "C.S5, "             // 39
            "C.S6, "             // 40
            "C.S7, "             // 41
            "C.S8, "             // 42
            "C.S9, "             // 43
            "C.I0, "             // 44
            "C.I1, "             // 45
            "C.I2, "             // 46
            "C.I3, "             // 47
            "C.I4, "             // 48
            "C.I5, "             // 49
            "C.I6, "             // 50
            "C.I7, "             // 51
            "C.I8, "             // 52
            "C.I9, "             // 53
            "C.Cap, "            // 54
            "C.Jail "            // 55
            "FROM retrib_pc AS A "
            "LEFT JOIN retrib_pc_stats AS B ON (A.ID = B.ID) "
            "LEFT JOIN retrib_pc_synergy AS C ON (A.ID = C.ID) "
        "WHERE A.ID = %u;";
    int32 Result = Sql_Query(SqlHandle, Query, this->ID);
    
    if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        // Column incrementer
        uint8 C = 0;

        JobsTo75 = (uint32)Sql_GetUIntData(SqlHandle, C++);
        Areas    = (uint8 )Sql_GetUIntData(SqlHandle, C++);

        // Serialized Arrays
        size_t Length = 0;
        char* Buffer = nullptr;
        /*Sql_GetData(SqlHandle, C++, &Buffer, &Length);
        memcpy(&Gear, Buffer, (Length > sizeof(Gear) ? sizeof(Gear) : Length));*/
        
        Length = 0;     
        Buffer = nullptr;
        Sql_GetData(SqlHandle, C++, &Buffer, &Length);
        memcpy(&Quest->Quests, Buffer, (Length > sizeof(Quest->Quests) ? sizeof(Quest->Quests) : Length));
        
        Length = 0;
        Buffer = nullptr;
        Sql_GetData(SqlHandle, C++, &Buffer, &Length);
        memcpy(&Quest->Repeats, Buffer, (Length > sizeof(Quest->Repeats) ? sizeof(Quest->Repeats) : Length));

        IsHunter = (bool)Sql_GetUIntData(SqlHandle, C++);

        Length = 0;
        Buffer = nullptr;
        Sql_GetData(SqlHandle, C++, &Buffer, &Length);
        memcpy(&AHP, Buffer, (Length > sizeof(AHP) ? sizeof(AHP) : Length));

        // Positioning Data        
        LastPosition.X = (float )Sql_GetFloatData(SqlHandle, C++);
        LastPosition.Y = (float )Sql_GetFloatData(SqlHandle, C++);
        LastPosition.Z = (float )Sql_GetFloatData(SqlHandle, C++);
        LastPosition.R = (uint8 )Sql_GetUIntData (SqlHandle, C++);
        LastPosition.A = (uint16)Sql_GetUIntData (SqlHandle, C++);

        // Stats
        for (uint8 X = Retrib::Stat::STAT_WEAPONSKILL; X <= Retrib::Stat::STAT_CRAFTTO100; X++)
            Stats[X] = (uint32)Sql_GetUIntData(SqlHandle, C++);

        // Synergy Data
        for (uint8 X = 0; X < 10; X++)
            Synergy->SetSkill(X, (uint16)Sql_GetUIntData(SqlHandle, C++));

        for (uint8 X = 0; X < 10; X++)
            Synergy->SetItems(X, (uint16)Sql_GetUIntData(SqlHandle, C++));

        Synergy->SetTier ((uint8 )Sql_GetUIntData(SqlHandle, C++));
        Synergy->SetJail ((bool  )Sql_GetUIntData(SqlHandle, C++));
    }
    
    // Hunter Data
    if (this->IsHunter)
        this->Hunter->LoadHunt();
}

auto CRetribPlayer::RegisterHunter(void) -> void
{
    const char* Query = "UPDATE retrib_pc SET Hunter = 1 WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, this->ID);
    this->IsHunter = true;
}

auto CRetribPlayer::HasMessageAuthority() -> bool
{
    return this->MessageAuthority;
}
auto CRetribPlayer::SetMessageAuthority(bool Set) -> void
{
    this->MessageAuthority = Set;
}

auto CRetribPlayer::GetStat(uint8 S) -> uint16
{
    return Stats[S];
}

auto CRetribPlayer::AddStat(uint8 Stat, int16 Points) -> void
{
    Stats[Stat]++;
    const char* Query = "UPDATE retrib_pc_stats SET %s = %s + 1, Points = Points + %u WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, StatColumn[Stat], StatColumn[Stat], Points, this->ID);
    
    if (ServerEvent->SA->IsActive() && ServerEvent->SA->GetTask() == Stat)
    {
        ServerEvent->SA->AddPoints(this->ID, Points);
    }
}

auto CRetribPlayer::AddStatPVP(uint8 Stat, int16 Points) -> void
{
    Stats[Stat]++;
    const char* Query = "UPDATE retrib_pc_stats SET %s = %s + 1, Points = Points + %u WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, StatColumn[Stat], StatColumn[Stat], Points, this->ID);

    if (ServerEvent->SA->IsActive())
    {
        ServerEvent->SA->AddPoints(this->ID, Points);
    }
}

auto CRetribPlayer::DelStat(uint8 Stat, int16 Points) -> void
{
    Stats[Stat]++;
    const char* Query = "UPDATE retrib_pc_stats SET %s = %s + 1, Points = Points - %u WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, StatColumn[Stat], StatColumn[Stat], Points, this->ID);

    if (ServerEvent->SA->IsActive() && ServerEvent->SA->GetTask() == Stat)
    {
        ServerEvent->SA->DelPoints(this->ID, Points);
    }
}

auto CRetribPlayer::CalculatePoints(void) -> void
{
    uint32 Points = 0;
    for (uint8 x = 0; x <= Retrib::Stat::STAT_CRAFTTO100; x++)
        Points += Stats[x] * StatPoints[x];
    for (uint8 x = 0; x <= Retrib::Gear::GEAR_NM_MISC; x++)
        Points += Gear[x].size() * GearPoints[x];
    const char* Query = "UPDATE retrib_pc_stats SET Points = %u WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, Points, this->ID);
}

auto CRetribPlayer::ObtainGear(uint8 Special, uint16 ItemID) -> void
{
    if (Gear[Special].find(ItemID) == Gear[Special].end())
    {
        Gear[Special].insert(ItemID);
        const char* Query = "UPDATE retrib_pc SET Gear = '%s' WHERE ID = %u;";
        char Buffer[sizeof(this->Gear) * 2 + 1];
        Sql_EscapeStringLen(SqlHandle, Buffer, (const char*)&this->Gear, sizeof(this->Gear));
        Sql_Query(SqlHandle, Query, Buffer, this->ID);
        Query = "UPDATE retrib_pc_stats SET Points = Points + %u WHERE ID = %u;";
        Sql_Query(SqlHandle, Query, GearPoints[Special], this->ID);
    }
    // RETRIB - Avarati Challenge
    if (ServerEvent->SA->IsActive() && ServerEvent->SA->GetTask() == Retrib::Stat::STAT_GEAR)
    {
        if (!this->Event->HasGear(Special, ItemID))
        {
            this->Event->AddGear(Special, ItemID);
            ServerEvent->SA->AddPoints(this->ID, GearPoints[Special]);
        }
    }
}

auto CRetribPlayer::HasJobTo75(uint8 Job) -> bool
{
    return (bool)(this->JobsTo75 & (1 << Job));
}

auto CRetribPlayer::SetJobTo75(uint8 Job) -> void
{
    this->JobsTo75 |= (1 << Job);
    const char* Query = "UPDATE retrib_pc SET JT75 = %u WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, this->JobsTo75, this->ID);
}

auto CRetribPlayer::HasAggro(void) -> bool
{
    return this->Aggro;
}

auto CRetribPlayer::SetAggro(bool Set) -> void
{
    if (!Aggro && Set)
    {
        this->PC->speed = 50;
        this->PC->speedsub = 50;
    }
    else if (Aggro && !Set)
    {
        this->PC->speed = 80;
        this->PC->speedsub = 80;
    }
    this->Aggro = Set;
}

auto CRetribPlayer::CanWarp(void) -> bool
{
	uint8 BannedZones[] = {1,3,15,37,38,39,40,41,42,43,45,46,47,58,59,73,74,75,76,131,132,134,135,185,
						   186,187,188,214,215,216,217,218,220,221,223,224,225,226,227,228,253,254,255};

	uint16 ZoneID = PC->getZone();
	for (auto ID : BannedZones)
		if (ID == ZoneID)
			return false;

	if (!PC->PAI->IsEngaged() && !this->Aggro)
		if (PC->status == STATUS_NORMAL || PC->animation == ANIMATION_NONE)
			if (!PC->isInDynamis() && !this->Synergy->IsInJail()) // To DO Add Default Jail
				return true;

	return false;
}

auto CRetribPlayer::AddArea(uint8 Area) -> void
{
    this->Areas |= (1 << Area);
    const char* Query = "UPDATE retrib_pc SET Areas = %u WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, this->Areas, this->ID);
}
auto CRetribPlayer::CanAccessArea(uint8 Area) -> bool
{
    return (bool)(Areas & (1 << Area));
}

auto CRetribPlayer::GetLastPosition(void) -> Coordinates
{
    return LastPosition;
}
auto CRetribPlayer::SetLastPosition(Coordinates &C) -> void
{
    LastPosition.X = C.X;
    LastPosition.Y = C.Y;
    LastPosition.Z = C.Z;
    LastPosition.R = C.R;
    LastPosition.A = C.A;

    const char* Query = "UPDATE retrib_pc SET X = %f, Y = %f, Z = %f, R = %u, A = %u WHERE ID = %u;";
    Sql_Query(SqlHandle, 
        Query, 
        LastPosition.X,
        LastPosition.Y,
        LastPosition.Z,
        LastPosition.R,
        LastPosition.A,
        this->ID);
}

auto CRetribPlayer::SendToLastPosition(void) -> bool
{
	if (!this->LastPosition.A)
        return false;

    this->PC->loc.p.x         = this->LastPosition.X;
    this->PC->loc.p.y         = this->LastPosition.Y;
    this->PC->loc.p.z         = this->LastPosition.Z;
    this->PC->loc.p.rotation  = this->LastPosition.R;
    this->PC->loc.destination = this->LastPosition.A;

    this->PC->status = STATUS_DISAPPEAR;
    this->PC->loc.boundary = 0;
    this->PC->m_moghouseID = 0;
    this->PC->clearPacketList();
    charutils::SendToZone(this->PC, 2, zoneutils::GetZoneIPP(this->PC->loc.destination));
    this->PC->updatemask |= UPDATE_POS;
    Coordinates C;
	this->LastPosition = {};

    return true;
}

auto CRetribPlayer::SendToMoghouse() -> void
{
	uint16 Zone = this->PC->getZone();
	this->PC->loc.destination = Zone;
	this->PC->m_moghouseID    = this->ID;
	this->PC->loc.prevzone    = Zone;	
	this->PC->loc.p.x = 0.f;
	this->PC->loc.p.y = 0.f;
	this->PC->loc.p.z = 0.f;
	this->PC->loc.p.rotation = 0;
	this->PC->loc.boundary   = 0;
	this->PC->updatemask = 0;
	this->PC->status    = STATUS_DISAPPEAR;
	this->PC->animation = ANIMATION_NONE;
	this->PC->clearPacketList();

	charutils::SendToZone(this->PC, 2, zoneutils::GetZoneIPP(Zone));		
}

auto CRetribPlayer::SaveRetribHomepoints() -> void
{
    const char* Query = "UPDATE retrib_pc SET AHP = '%s' WHERE ID = %u;";
    char Buffer[sizeof(this->AHP) * 2 + 1];
    Sql_EscapeStringLen(SqlHandle, Buffer, (const char*)&this->AHP, sizeof(this->AHP));
    Sql_Query(SqlHandle, Query, Buffer, this->ID);
}

auto CRetribPlayer::GetRetribHPStage(uint8 HP) -> uint8
{
    return AHP[HP];
}

auto CRetribPlayer::AddRetribHPStage(uint8 HP) -> void
{
    this->AHP[HP]++;
    SaveRetribHomepoints();
}

auto CRetribPlayer::AddRetribHomepoint(uint8 HP) -> void
{
    AHP[HP] = 2;
    SaveRetribHomepoints();
}

auto CRetribPlayer::DelRetribHomepoint(uint8 HP) -> void
{
    AHP[HP] = 0;
    SaveRetribHomepoints();
}

auto CRetribPlayer::HasRetribHomepoint(uint8 HP) -> bool
{
    return AHP[HP] >= 2;
}

auto CRetribPlayer::GetRetribHomepointCount(void) -> uint8
{
    uint8 Count = 0;
    for (uint8 x = 0; x < 23; x++)
        if (this->AHP[x] >= 2)
            Count++;
    return Count;
}