/**************************************************************************
 Retrib Utility Methods
**************************************************************************/

#include "../utils/charutils.h"
#include "../utils/zoneutils.h"
#include "../packets/position.h"
#include <fstream>
#include "retrib_utils.h"

namespace RetribUtils
{

    auto UpdatePosition(CCharEntity* PC, CBaseEntity* NPC) -> void
    {	
        uint32 ID = NPC->id;
        NPC->loc.p.x = PC->loc.p.x;
        NPC->loc.p.y = PC->loc.p.y;
        NPC->loc.p.z = PC->loc.p.z;
        NPC->loc.p.rotation = PC->loc.p.rotation;
        
        const char* Query = "UPDATE npc_list SET pos_x = %f, pos_y = %f, pos_z = %f, pos_rot = %d WHERE npcid = %d;";

        Sql_Query(SqlHandle, Query, NPC->loc.p.x, NPC->loc.p.y, NPC->loc.p.z, NPC->loc.p.rotation, ID);

        NPC->loc.zone->PushPacket(NPC, CHAR_INRANGE, new CPositionPacket(NPC));
        NPC->updatemask |= UPDATE_POS;
        
        const char* File = "npc-updates.txt";
        std::string Q = "UPDATE npc_list SET pos_x = " + std::to_string(NPC->loc.p.x)
                        + ", pos_y = " + std::to_string(NPC->loc.p.y)
                        + ", pos_z = " + std::to_string(NPC->loc.p.z)
                        + ", pos_rot = " + std::to_string(NPC->loc.p.rotation)
                        + " WHERE npcid = "	+ std::to_string(ID) + ";";
        std::ofstream Log;
        Log.open(File, std::ios::app);
        Log << Q;
        Log.close();
    }

    auto SaveZonePoint(CCharEntity* PC) -> void
    {
        const char* Query = "INSERT INTO retrib_data_zones VALUES(%u,%u,%f,%f,%f);";
        Sql_Query(SqlHandle, Query, PC->loc.zone->GetID(), PC->loc.p.rotation, PC->loc.p.x, PC->loc.p.y, PC->loc.p.z);
    }

    auto SavePathPoint(CCharEntity* PC) -> void
    {
        const char* Query = "INSERT INTO retrib_data_paths VALUES(%f,%f,%f);";
        Sql_Query(SqlHandle, Query, PC->loc.p.x, PC->loc.p.y, PC->loc.p.z);
    }

    auto SendTo(CCharEntity* PC, uint16 Area) -> void
    {
        float  X = 0.f;
        float  Y = 0.f;
        float  Z = 0.f;
        uint8  R = 0;

        const char* Query = "SELECT X,Y,Z,R FROM retrib_data_zones WHERE A = %u;";
        int32 Result = Sql_Query(SqlHandle, Query, Area);

        if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            X = (float)Sql_GetFloatData(SqlHandle, 0);
            Y = (float)Sql_GetFloatData(SqlHandle, 1);
            Z = (float)Sql_GetFloatData(SqlHandle, 2);
            R = (uint8)Sql_GetUIntData (SqlHandle, 3);
        }

        PC->loc.p.x 			= X;
        PC->loc.p.y 			= Y;
        PC->loc.p.z 		   	= Z;
        PC->loc.p.rotation  	= R;
        PC->loc.destination 	= Area;

        PC->status = STATUS_DISAPPEAR;
        PC->loc.boundary = 0;
        PC->m_moghouseID = 0;
        PC->clearPacketList();
        charutils::SendToZone(PC, 2, zoneutils::GetZoneIPP(PC->loc.destination));
        PC->updatemask |= UPDATE_POS;
    }

    auto ScrambleEggs() -> void
    {
        // TO DO - Reload Mob Tables
        uint16 DropID[26];
        memset(&DropID, 0, sizeof(DropID));
        std::vector<uint16> Mobs;
        uint8 X = 0;
        
        const char* Query = "DELETE FROM mob_droplist WHERE itemId >= 1488 AND itemId <= 1513;";
        
        Sql_Query(SqlHandle, Query);
        
        Query = "SELECT DISTINCT a.poolid, a.mobType, b.dropid, b.maxLevel FROM mob_pools AS a LEFT JOIN mob_groups AS b \
                 USING (poolid) WHERE a.mobType = 2 AND b.maxLevel > 3 AND b.maxLevel < 90 AND b.dropid != 0 ORDER BY maxLevel ASC;";
        
        int32 ret = Sql_Query(SqlHandle, Query);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            uint8 Group = (uint8)(Sql_GetUIntData(SqlHandle, 3) / 10.f * 3) - 1; // 0 -> 25
            if (Group != X)
            {
                // Moving on to new group, save a random Drop ID from what was gathered
                DropID[X++] = Mobs[tpzrand::GetRandomNumber(Mobs.size() - 1)];
                Mobs.clear(); // Clear if entering new group, then continue inserting
            }
            Mobs.push_back((uint16)Sql_GetUIntData(SqlHandle, 2));
        }

        for (uint8 x = 0; x < 26; x++)
        {
            uint8 Rate = (9 - (uint8)(x / 3.f)) * 10; // Common: 90(9%) -> Rare: 10(1%)
            Query = "INSERT INTO mob_droplist VALUES(%u,'0','0','1000',%u,%u);";
            Sql_Query(SqlHandle, Query, DropID[x], 1488 + x, Rate); // 1488 = A Egg -> 1513 = Z Egg
        }
        ShowInfo(CL_WHITE"Egg drops redistributed\n" CL_RESET);
    }

}; // RetribUtils