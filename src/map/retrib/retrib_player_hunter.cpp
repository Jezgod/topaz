/**************************************************************************
 Retrib Player Class
**************************************************************************/
#include "../utils/charutils.h"
#include "retrib_player_hunter.h"

CRetribPlayerHunter::CRetribPlayerHunter(uint16 ID)
{
    this->ID = ID;
}

CRetribPlayerHunter::~CRetribPlayerHunter()
{
}

auto CRetribPlayerHunter::LoadHunt() -> void
{
    Hunt = {};

    const char* Query = 
        "SELECT "
            "A.MID, B.Name, A.DBName, A.XP, A.Gil, A.Zone, A.Killed "
        "FROM retrib_pc_hunts AS A "
        "LEFT JOIN retrib_data_hunts AS B ON (A.MID = B.MID) "
        "WHERE ID = %u;";
    int32 Result = Sql_Query(SqlHandle, Query, ID); 

    if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        Hunt.MID    = (uint32)Sql_GetUIntData(SqlHandle, 0);
        Hunt.Name.insert(0, (const char*)Sql_GetData(SqlHandle, 1));
        Hunt.DBName.insert(0, (const char*)Sql_GetData(SqlHandle, 2));
        Hunt.XP     = (uint16)Sql_GetUIntData(SqlHandle, 3);
        Hunt.Gil    = (uint16)Sql_GetUIntData(SqlHandle, 4);
        Hunt.Zone   = (uint16)Sql_GetUIntData(SqlHandle, 5);
        Hunt.Killed = (bool  )Sql_GetUIntData(SqlHandle, 6);
    }
}

auto CRetribPlayerHunter::GetNewHunt (uint8 Level) -> Hunt_t
{
    Hunt = {};
    const char* Query = "SELECT MID, Name, DBName, Gender, XP, Gil, Zone, ZoneText FROM retrib_data_hunts WHERE Level <= %u ORDER BY RAND() LIMIT 1;";
    int32 Result = Sql_Query(SqlHandle, Query, Level);
    
    if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        Hunt.MID    = (uint32)Sql_GetUIntData(SqlHandle, 0);
        Hunt.Name.insert  (0, (const char*)Sql_GetData(SqlHandle, 1));
        Hunt.DBName.insert(0, (const char*)Sql_GetData(SqlHandle, 2));
        Hunt.Gender = (uint8 )Sql_GetUIntData(SqlHandle, 3);
        Hunt.XP     = (uint16)Sql_GetUIntData(SqlHandle, 4);
        Hunt.Gil    = (uint16)Sql_GetUIntData(SqlHandle, 5);
        Hunt.Zone   = (uint16)Sql_GetUIntData(SqlHandle, 6);
        Hunt.ZNText.insert(0, (const char*)Sql_GetData(SqlHandle, 7));
        Hunt.Killed = false;
    }

    Query = "INSERT INTO retrib_pc_hunts VALUES(%u,%u,'%s',%u,%u,%u,0);";
    Sql_Query(SqlHandle, Query, 
        this->ID,
        Hunt.MID,
        Hunt.DBName.c_str(),
        Hunt.XP,
        Hunt.Gil,
        Hunt.Zone
    );

    return Hunt;
}

auto CRetribPlayerHunter::GetHunt (void) -> Hunt_t
{
    return Hunt;
}

auto CRetribPlayerHunter::GetHuntTarget (void) -> std::string
{
    return Hunt.Name;
}

auto CRetribPlayerHunter::HasHunt(void) -> bool
{
    return Hunt.MID != 0;
}

auto CRetribPlayerHunter::DeleteHunt(void) -> void
{
    Hunt = {};
    const char* Query = "DELETE FROM retrib_pc_hunts WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, this->ID);
}

auto CRetribPlayerHunter::HasKilledTarget (void) -> bool
{
    return Hunt.Killed;
}

auto CRetribPlayerHunter::KillHuntTarget (void) -> uint16
{
    Hunt.Killed = true;
    const char* Query = "UPDATE retrib_pc_hunts SET Killed = 1 WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, this->ID);
    return Hunt.XP;
}