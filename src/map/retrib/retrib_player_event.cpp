/**************************************************************************
 Retrib Player Class
**************************************************************************/
#include "retrib_events.h"
#include "retrib_player_event.h"
#include "retrib_enums.h"

extern CRetribEvent* ServerEvent;

CRetribPlayerEvent::CRetribPlayerEvent(uint16 ID)
{
    this->ID = ID;

    if (ServerEvent->SA->IsActive())
    {
        const char* Query  = "SELECT Areas, Gear FROM retrib_pc_strongest WHERE ID = %u;";
        int32 Result = Sql_Query(SqlHandle, Query, ID);

        if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            size_t Length = 0;
            char* Buffer = nullptr;
            Sql_GetData(SqlHandle, 0, &Buffer, &Length);
            memcpy(&Area, Buffer, (Length > sizeof(Area) ? sizeof(Area) : Length));

            Length = 0;
            Buffer = nullptr;
            Sql_GetData(SqlHandle, 1, &Buffer, &Length);
            memcpy(&Gear, Buffer, (Length > sizeof(Gear) ? sizeof(Gear) : Length));
        }
    }
}

CRetribPlayerEvent::~CRetribPlayerEvent()
{
}

///************************************************************************************
//* Event NPC Targets
//************************************************************************************/

auto CRetribPlayerEvent::GetEventNPC(void) -> uint32
{
    return this->EventNPC;
}

auto CRetribPlayerEvent::SetEventNPC(uint32 NPC) -> void
{
    this->EventNPC = NPC;
}

///************************************************************************************
//* Stat Rankings
//************************************************************************************/

auto CRetribPlayerEvent::GetRankings(std::string Top3[], uint32 Totals[]) -> uint32
{
    uint16 Rank = 0;
    const char* Query = "SELECT Name, Points FROM retrib_pc_stats ORDER BY Points DESC LIMIT 3;";
    int32 Result = Sql_Query(SqlHandle, Query);

    if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        uint8 x = 0;
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            Top3[x].insert(0, (const char*)Sql_GetData(SqlHandle, 0));
            Totals[x] = (uint32)Sql_GetUIntData(SqlHandle, 1);
            x++;
        }
    }

    Query = "SELECT 1 + COUNT(*) AS rank FROM retrib_pc_stats WHERE Points > (SELECT Points FROM retrib_pc_stats WHERE ID = %u);";
    Result = Sql_Query(SqlHandle, Query, this->ID);

    if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        Rank = (uint16)Sql_GetUIntData(SqlHandle, 0);
    }
    return Rank;
}

///************************************************************************************
//* Stat Points
//************************************************************************************/
auto CRetribPlayerEvent::GetTotalPoints(uint16 ID)->uint32
{
    uint32 Value = 0;

    const char* Query = "SELECT Points FROM retrib_pc_stats WHERE ID = %u;";
    int32 Result = Sql_Query(SqlHandle, Query, ID);

    if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        Value = (uint32)Sql_GetUIntData(SqlHandle, 0);
    }
    return Value;
}

/************************************************************************************
* Bounty Ranking Name
************************************************************************************/

auto CRetribPlayerEvent::GetBounty(std::string Top3[]) -> uint16
{
    uint16 Rank = 0;
    int8 x = 0;
    const char* Query =
        "SELECT charname, VALUE FROM char_vars "
        "INNER JOIN chars "
        "ON char_vars.charid = chars.charid "
        "WHERE varname = 'bounty_points' "
        "ORDER BY VALUE DESC, charname ASC "
        "LIMIT 3;";
    int32 Result = Sql_Query(SqlHandle, Query);

    if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            Top3[x++].insert(0, (const char*)Sql_GetData(SqlHandle, 0));                 
    }

    return Rank;
}

/************************************************************************************
* Bounty Ranking Points
************************************************************************************/

auto CRetribPlayerEvent::GetBountyPoints(std::string Top3S[]) -> uint16
{
    uint16 points = 0;
    int8 y = 0;
    const char* Query =
        "SELECT charname, VALUE FROM char_vars "
        "INNER JOIN chars "
        "ON char_vars.charid = chars.charid "
        "WHERE varname = 'bounty_points' "
        "ORDER BY VALUE DESC, charname ASC "
        "LIMIT 3;";
    int32 Result = Sql_Query(SqlHandle, Query);

    if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            Top3S[y++].insert(0, (const char*)Sql_GetData(SqlHandle, 1));
    }

    return points;
}

/************************************************************************************
* Daily Login
************************************************************************************/

auto CRetribPlayerEvent::HasDailyGift(void) -> bool
{
    return this->HasGift;
}

auto CRetribPlayerEvent::ResetDailyGift(void) -> void
{
    this->HasGift = false;
}

auto CRetribPlayerEvent::GiveDailyGift(void) -> void
{
    this->HasGift = true;
    const char* Query = "UPDATE retrib_pc_daily SET HasGift = 1 WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, this->ID);
}

auto CRetribPlayerEvent::SetDailyGiftDay(uint8 Day) -> void
{
    this->GiftDay = Day;
}

auto CRetribPlayerEvent::GetDailyGiftDay(void) -> uint8
{
    return this->GiftDay;
}

/************************************************************************************
* Strongest Adventurer
************************************************************************************/

auto CRetribPlayerEvent::HasVisitedArea(uint16 Region, uint16 Zone) -> bool
{
    if (Area[Region].empty())
    {
        Area[Region].insert(Zone);
        char Buffer[sizeof(this->Area) * 2 + 1];
        Sql_EscapeStringLen(SqlHandle, Buffer, (const char*)&this->Area, sizeof(this->Area));
        const char* Query = "UPDATE retrib_pc_strongest SET Areas = '%s' WHERE ID = %u;";
        Sql_Query(SqlHandle, Query, Buffer, this->ID);
        return true;
    }
    else
    {
        if ((Area[Region].find(Zone) != Area[Region].end()))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
}
auto CRetribPlayerEvent::AddArea(uint16 Region, uint16 Zone) -> void
{
    Area[Region].insert(Zone);
    char Buffer[sizeof(this->Area) * 2 + 1];
    Sql_EscapeStringLen(SqlHandle, Buffer, (const char*)&this->Area, sizeof(this->Area));
    const char* Query = "UPDATE retrib_pc_strongest SET Areas = '%s' WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, Buffer, this->ID);
}
auto CRetribPlayerEvent::HasGear(uint8 Special, uint16 ItemID) -> bool
{
    return (Gear[Special].find(ItemID) != Gear[Special].end());
}
auto CRetribPlayerEvent::AddGear(uint8 Special, uint16 ItemID) -> void
{
    Gear[Special].insert(ItemID);
    char Buffer[sizeof(this->Gear) * 2 + 1];
    Sql_EscapeStringLen(SqlHandle, Buffer, (const char*)&this->Gear, sizeof(this->Gear));
    const char* Query = "UPDATE retrib_pc_strongest SET Gear = '%s' WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, Buffer, this->ID);
}