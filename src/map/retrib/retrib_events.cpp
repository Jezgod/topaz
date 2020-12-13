/**************************************************************************
 Retrib Strongest Adventurer Methods
**************************************************************************/

#include "retrib_events.h"
#include "../message.h"
#include "../utils/zoneutils.h"
#include "../packets/chat_message.h"
#include <vector>
#include <string>

extern bool  EVENT_SERVER;
extern uint8 SERVER_DAY;
extern uint8 SERVER_WEEK;
const uint8 START = 1;
const uint8 DAY   = 2;
const uint8 END   = 3;

const char* DT[7] = {"D1","D2","D3","D4","D5","D6","D7"};

std::vector<std::vector<uint8>> Tasks =
{
    {Retrib::Stat::STAT_BATTLEFIELD},
    {Retrib::Stat::STAT_MINING,      Retrib::Stat::STAT_LOGGING,   Retrib::Stat::STAT_HARVESTING, Retrib::Stat::STAT_EXCAVATING},
    {Retrib::Stat::STAT_QUEST,       Retrib::Stat::STAT_MISSION},
    {Retrib::Stat::STAT_NQ_SYNTH,    Retrib::Stat::STAT_HQ_SYNTH}, //Retrib::Stat::STAT_ENHANCEMENT
    {Retrib::Stat::STAT_MOB_KILL,    Retrib::Stat::STAT_NM_KILL},
    {Retrib::Stat::STAT_VALOR,       Retrib::Stat::STAT_HUNT},
    {Retrib::Stat::STAT_EXPERIENCE}
};

std::vector<std::vector<std::string>> TaskTexts =
{
    {"Win BCNMs and Battlefield Events"},
    {"Mine Materials", "Log Materials", "Harvest Materials", "Excavate Materials"},
    {"Complete Quests", "Complete Missions"},
    {"Create Normal-Quality Items", "Create High-Quality Items"}, //"Enhance Gear"
    {"Kill Experience-Granting Mobs", "Kill NMs"},
    {"Complete Regimes (FoV and GoV)", "Complete Hunts"},
    {"Gain Experience Points"}
};

uint32 GilQty[3][3] = 
{
    {2000000, 1000000, 500000},
    {1000000, 500000, 250000},
    {500000, 250000, 125000}
};

std::string GilText[3][3] = 
{
    {"2,000,000", "1,000,000", "500,000"},
    {"1,000,000", "500,000", "250,000"},
    {"500,000", "250,000", "125,000"}
};

CStrongest::CStrongest()
{
    memset(&Rewards, 0, sizeof(Rewards));
    memset(&Winners, 0, sizeof(Winners));
    Active = false;
}
CStrongest::~CStrongest()
{

}

auto CStrongest::ClearData(bool All) -> void
{
    WinNames[0].clear();
    WinNames[1].clear();
    WinNames[2].clear();
    WinNames[3].clear();
    
    if (All)
    {
        RewardText[0].clear();
        RewardText[1].clear();
        RewardText[2].clear();
        RewardText[3].clear();
        memset(&Rewards, 0, sizeof(Rewards));
        memset(&Winners, 0, sizeof(Winners));
    }
}

auto CStrongest::LoadData() -> void
{
    //PROBLEM HERE FOR OTHER SERVERS??
    if (SERVER_DAY <= 6)
        Active = true;

    ClearData(true);

    const char* Query = "SELECT Task, `Index`, Gil, R1ID, R2ID, R3ID, DID, DQty FROM retrib_data_strongest;";
    int32 Result = Sql_Query(SqlHandle, Query);

    if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        Task = (uint8)Sql_GetUIntData(SqlHandle, 0);
        Index = (uint8)Sql_GetUIntData(SqlHandle, 1);
        Gil = (uint8)Sql_GetUIntData(SqlHandle, 2);

        Rewards[0] = (uint16)Sql_GetUIntData(SqlHandle, 3);
        Rewards[1] = (uint16)Sql_GetUIntData(SqlHandle, 4);
        Rewards[2] = (uint16)Sql_GetUIntData(SqlHandle, 5);
        Rewards[3] = (uint16)Sql_GetUIntData(SqlHandle, 6);
        Rewards[4] = (uint16)Sql_GetUIntData(SqlHandle, 7);

        /*size_t Length = 0;
        char* Buffer = nullptr;
        Sql_GetData(SqlHandle, 3, &Buffer, &Length);
        memcpy(&Rewards, Buffer, (Length > sizeof(Rewards) ? sizeof(Rewards) : Length));

        Length = 0;
        Buffer = nullptr;
        Sql_GetData(SqlHandle, 4, &Buffer, &Length);
        memcpy(&Winners, Buffer, (Length > sizeof(Winners) ? sizeof(Winners) : Length));*/
    }

    Query = "SELECT Item FROM retrib_items_strongest WHERE ID = %u OR ID = %u OR ID = %u OR ID = %u ORDER BY Rank ASC;";
    Result = Sql_Query(SqlHandle, Query, Rewards[0], Rewards[1], Rewards[2], Rewards[3]);

    if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        uint8 x = 0;
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            RewardText[x].insert(0, (const char*)Sql_GetData(SqlHandle, 0));
            x++;
           /* RewardText[0] = (const char*)Sql_GetData(SqlHandle, 0);
            RewardText[1] = (const char*)Sql_GetData(SqlHandle, 1);
            RewardText[2] = (const char*)Sql_GetData(SqlHandle, 2);
            RewardText[3] = (const char*)Sql_GetData(SqlHandle, 3);  */   
        }
    }
}

auto CStrongest::SaveData() -> void
{
    /*char RewardData[sizeof(Rewards) * 2 + 1];
    Sql_EscapeStringLen(SqlHandle, RewardData, (const char*)&Rewards, sizeof(Rewards));
    char RewardDataText[sizeof(RewardText) * 2 + 1];
    Sql_EscapeStringLen(SqlHandle, RewardDataText, (const char*)&RewardText, sizeof(RewardText));
    char WinnerData[sizeof(Winners) * 2 + 1];
    Sql_EscapeStringLen(SqlHandle, WinnerData, (const char*)&Winners, sizeof(Winners));*/

    const char* Query =
        "UPDATE retrib_data_strongest SET "
        "Week = %u, "
        "Day = %u, "
        "Task = %u, "
        "`Index` = %u, "
        "Gil = %u, "
        "R1ID = %u, "
        "R1Text = '%s', "
        "R2ID = %u, "
        "R2Text = '%s', "
        "R3ID = %u, "
        "R3Text = '%s', "
        "DID = %u, "
        "DText = '%s', "
        "DQty = %u;";
       
    Sql_Query(SqlHandle, Query,
        SERVER_WEEK,
        SERVER_DAY,
        Task,
        Index,
        Gil,
        Rewards[0],
        RewardText[0],
        Rewards[1],
        RewardText[1],
        Rewards[2],
        RewardText[2],
        Rewards[3],
        RewardText[3],
        Rewards[4]
    );
}

auto CStrongest::UpdateData(uint8 Type) -> void
{
    uint16 ID = 0;
    const char* Query = "SELECT charid FROM accounts_sessions LIMIT 1;";
    int32 Result = Sql_Query(SqlHandle, Query);

    if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        ID = (uint16)Sql_GetUIntData(SqlHandle, 0);
    }

    CCharEntity* PC = zoneutils::GetChar(ID);
    if (PC)
    {
        PC->RPC->SetMessageAuthority(true);
        SendAnnouncement(PC, Type);
        PC->RPC->SetMessageAuthority(false);
    }

    char Data[4];
    ref<uint8 >(&Data, 0) = 1;
    ref<uint16>(&Data, 1) = PC ? 0 : ID;
    ref<uint8> (&Data, 3) = Type;
    message::send(MSG_UPDATE_EVENT, &Data[0], sizeof(Data), nullptr);
}

auto CStrongest::SendAnnouncement(CCharEntity* PC, uint8 Type) -> void
{
    if (Type == START)
    {
        std::string M1 = "~~~The Avarati Strongest Adventurer Campaign has begun!~~~";
        std::string M2 = "Each day, a new challenge will be announced. Points may be earned by completing the tasks.";
        std::string M3 = "The adventurers with the most points at the end of the event will be rewarded with the following:";
        std::string M4 = "Rank 1 | " + RewardText[0] + " along with " + GilText[Gil][0] + " Gil.";
        std::string M5 = "Rank 2 | " + RewardText[1] + " along with " + GilText[Gil][1] + " Gil.";
        std::string M6 = "Rank 3 | " + RewardText[2] + " along with " + GilText[Gil][2] + " Gil.";
        std::string M7 = "Today's Challenge: " + TaskTexts[SERVER_DAY][Index] + ".";
        std::string M8 = "The adventurer with the most points today will receive " + std::to_string(Rewards[4]) + " " + RewardText[3] + ". Good luck!";

        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M1));
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M2));
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M3));
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M4));
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M5));
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M6));
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M7));
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M8));
    }
    else if (Type == DAY)
    {
        std::string M1 = "~~~Day " + std::to_string(SERVER_DAY) + " of the Avarati Strongest Adventurer Campaign has ended~~~";
        std::string M2 = "Congratulations to " + WinNames[3] + " for winning today's prize!";
        std::string M3 = "A new day has started! Today's challenge: " + TaskTexts[SERVER_DAY][Index] + ".";
        std::string M4 = "The adventurer with the most points today will receive " + std::to_string(Rewards[4]) + " " + RewardText[3] + ". Good luck!";

        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M1));
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M2));
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M3));
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M4));
    }
    else if (Type == END)
    {
        std::string M1 = "~~~The Avarati Strongest Adventurer Campaign has concluded~~~";
        std::string M2 = "First, congratulations to " + WinNames[3] + " for winning today's prize!";
        std::string M3 = "Three victors have emerged as the Strongest Adventurers for the weekly event:";
        std::string M4 = "Rank 1: " + WinNames[0] + " | Rank 2: " + WinNames[1] + " | Rank 3: " + WinNames[2];
        std::string M5 = "Congratulations to our winners! You may collect the rewards from your delivery box.";
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M1));
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M2));
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M3));
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M4));
        message::send(MSG_CHAT_SERVMES, 0, 0, new CChatMessagePacket(PC, MESSAGE_NS_LINKSHELL2, M5));
    }
}

auto CStrongest::Start() -> void
{
    this->Active = true;
    ClearData(true);
    ResetPoints();
    SetRewards(START);
    SetTask();
    SaveData();
    UpdateData(START);
}
auto CStrongest::NewDay() -> void
{
    GiveRewards(DAY);
    SetRewards(DAY);
    SetTask();
    SaveData();
    UpdateData(DAY);
}
auto CStrongest::Finish() -> void
{
    this->Active = false;
    GiveRewards(END);
    SaveData();
    UpdateData(END);
}

auto CStrongest::SetTask() -> void
{
    Index = tpzrand::GetRandomNumber(0, (uint8)Tasks[SERVER_DAY].size() + 0);
    Task = Tasks[SERVER_DAY][Index];
}

auto CStrongest::GetTask() -> uint8
{
    return this->Task;
}

auto CStrongest::GetTask(std::string &T) -> void
{
    T.insert(0, TaskTexts[SERVER_DAY][Index]);
}

auto CStrongest::SetRewards(uint8 Type) -> void
{
    if (Type == START)
    {
        // SET WEEKLY ITEMS
        uint8 Tier = (uint8)tpzrand::GetRandomNumber(1, 100);
        
        if (Tier < 65)
            Tier = 1;
        else if (Tier < 85)
            Tier = 2;
        else
            Tier = 3;
        
        this->Gil = Tier - 1;
        
        const char* Query = "SELECT ID, Item FROM retrib_items_strongest WHERE Rank = %u AND Tier = %u ORDER BY RAND() LIMIT 1;";
        int32 Result = Sql_Query(SqlHandle, Query, 1, Tier);
        
        if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            Rewards[0] = (uint16)Sql_GetUIntData(SqlHandle, 0);
            RewardText[0].insert(0, (const char*)Sql_GetData(SqlHandle, 1));
        }
        Result = Sql_Query(SqlHandle, Query, 2, Tier);
        
        if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            Rewards[1] = (uint16)Sql_GetUIntData(SqlHandle, 0);
            RewardText[1].insert(0, (const char*)Sql_GetData(SqlHandle, 1));
        }
        Result = Sql_Query(SqlHandle, Query, 3, Tier);
        
        if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            Rewards[2] = (uint16)Sql_GetUIntData(SqlHandle, 0);
            RewardText[2].insert(0, (const char*)Sql_GetData(SqlHandle, 1));
        }
    }

    // SET DAILY ITEM
    RewardText[3].clear();
    const char* Query = "SELECT ID, Item, Qty FROM retrib_items_strongest WHERE Rank = 4 ORDER BY RAND() LIMIT 1;";
    int32 Result = Sql_Query(SqlHandle, Query);
    
    if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        Rewards[3] = (uint16)Sql_GetUIntData(SqlHandle, 0);
        RewardText[3].insert(0, (const char*)Sql_GetData(SqlHandle, 1));
        Rewards[4] = (uint8)Sql_GetUIntData(SqlHandle, 2);
    }
}

auto CStrongest::GetRewards(std::vector<std::string> &Items) -> void
{
    Items.push_back(RewardText[0]);
    Items.push_back(GilText[Gil][0]);
    Items.push_back(RewardText[1]);
    Items.push_back(GilText[Gil][1]);
    Items.push_back(RewardText[2]);
    Items.push_back(GilText[Gil][2]);
    Items.push_back(std::to_string(Rewards[4]));
    Items.push_back(RewardText[3]);
}

auto CStrongest::GiveRewards(uint8 Type) -> void
{
    ClearData(false);

    if (Type == END)
    {
        const char* Query = 
            "SELECT "
            "A.ID, B.charname "
            "FROM retrib_pc_strongest AS A "
            "LEFT JOIN chars AS B "
            "ON (A.ID = B.charid) "
            "ORDER BY Total DESC LIMIT 3;";

        int32 Result = Sql_Query(SqlHandle, Query);
        
        if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            uint8 x = 0;
            while(Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                Winners[x] = (uint16 )Sql_GetUIntData(SqlHandle, 0);
                WinNames[x].insert(0, (const char*)Sql_GetData(SqlHandle, 1));
                x++;
            }
        }
        const char* WeeklyItem = 
            "INSERT INTO delivery_box (charid, charname, box, itemid, itemsubid, quantity, senderid, sender) "
            "VALUES (%u, '%s', 1, %u, 0, %u, 0, 'Event Reward');";
        Sql_Query(SqlHandle, WeeklyItem, Winners[0], WinNames[0], Rewards[0], 1);
        Sql_Query(SqlHandle, WeeklyItem, Winners[1], WinNames[1], Rewards[1], 1);
        Sql_Query(SqlHandle, WeeklyItem, Winners[2], WinNames[2], Rewards[2], 1);
        Sql_Query(SqlHandle, WeeklyItem, Winners[0], WinNames[0], 65535, GilQty[Gil][0]);
        Sql_Query(SqlHandle, WeeklyItem, Winners[1], WinNames[1], 65535, GilQty[Gil][1]);
        Sql_Query(SqlHandle, WeeklyItem, Winners[2], WinNames[2], 65535, GilQty[Gil][2]);
    }
    
    const char* Query = 
        "SELECT "
        "A.ID, B.charname "
        "FROM retrib_pc_strongest AS A "
        "LEFT JOIN chars as B ON (A.ID = B.charid) "
        "ORDER BY %s DESC LIMIT 1;";
    int32 day = SERVER_DAY;
    if (day == 0)
    {
        day = 6;
    }
    else
    {
        day = day - 1;
    }
    int32 Result = Sql_Query(SqlHandle, Query, DT[day]);

    if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        Winners[3] = (uint16 )Sql_GetUIntData(SqlHandle, 0);
        WinNames[3].insert(0, (const char*)Sql_GetData(SqlHandle, 1));

        const char* DailyItem = 
            "INSERT INTO delivery_box (charid, charname, box, itemid, itemsubid, quantity, senderid, sender) "
            "VALUES (%u, '%s', 1, %u, 0, %u, 0, 'Event Reward');";
        Sql_Query(SqlHandle, DailyItem, Winners[3], WinNames[3], Rewards[3], Rewards[4]);
    }
}

auto CStrongest::GetRankings(std::string Top3[], uint32 Totals[], uint16 ID, bool Daily) -> uint32
{
    uint16 Rank = 0;

    if (!Daily) // Weekly
    {
        const char* Query = "SELECT Name, Total FROM retrib_pc_strongest ORDER BY Total DESC LIMIT 3;";
        int32 Result = Sql_Query(SqlHandle, Query);

        if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            uint8 y = 0;
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                Top3[y].insert(0, (const char*)Sql_GetData(SqlHandle, 0));
                Totals[y] = (uint32)Sql_GetUIntData(SqlHandle, 1);
                y++;
            }
        }

        Query = "SELECT 1 + COUNT(*) AS rank FROM retrib_pc_strongest WHERE Total > (SELECT Total FROM retrib_pc_strongest WHERE ID = %u);";
        Result = Sql_Query(SqlHandle, Query, ID);

        if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            Rank = (uint16)Sql_GetUIntData(SqlHandle, 0);
        }    
    }
    else //Daily
    {
        const char* Query = "SELECT Name, %s FROM retrib_pc_strongest ORDER BY %s DESC LIMIT 3;";
        int32 Result = Sql_Query(SqlHandle, Query, DT[SERVER_DAY], DT[SERVER_DAY]);

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

        Query = "SELECT 1 + COUNT(*) AS rank FROM retrib_pc_strongest WHERE %s > (SELECT %s FROM retrib_pc_strongest WHERE ID = %u);";
        Result = Sql_Query(SqlHandle, Query, DT[SERVER_DAY], DT[SERVER_DAY], ID);

        if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            Rank = (uint16)Sql_GetUIntData(SqlHandle, 0);
        }
    }
    return Rank;
}

auto CStrongest::GetTotalPoints(uint16 ID, bool Daily)->uint32
{
    uint16 Value = 0;

    if (!Daily) //Weekly
    {
        const char* Query = "SELECT Total FROM retrib_pc_strongest WHERE ID = %u;";
        int32 Result = Sql_Query(SqlHandle, Query, ID);

        if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            Value = (uint32)Sql_GetUIntData(SqlHandle, 0);
        }
    }
    else //Daily
    {
        const char* Query = "SELECT %s FROM retrib_pc_strongest WHERE ID = %u;";
        int32 Result = Sql_Query(SqlHandle, Query, DT[SERVER_DAY], ID);

        if (Result != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            Value = (uint32)Sql_GetUIntData(SqlHandle, 0);
        }
    }
    return Value;
}

auto CStrongest::AddPoints(uint16 ID, uint16 Points) -> void
{
    const char* Query = "UPDATE retrib_pc_strongest SET %s = %s + %u, Total = Total + %u WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, DT[SERVER_DAY], DT[SERVER_DAY], Points, Points, ID);
}

auto CStrongest::DelPoints(uint16 ID, uint16 Points) -> void
{
    const char* Query = "UPDATE retrib_pc_strongest SET %s = %s + %u, Total = Total - %u WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, DT[SERVER_DAY], DT[SERVER_DAY], Points, Points, ID);
}

auto CStrongest::ResetPoints() -> void
{
    const char* Query = "UPDATE retrib_pc_strongest SET Total = 0, D1 = 0, D2 = 0, D3 = 0, D4 = 0, D5 = 0, D6 = 0, D7 = 0, Areas = NULL, Gear = NULL";
    Sql_Query(SqlHandle, Query);
}

auto CStrongest::RegisterSA(uint16 ID, const char* name) -> void
{
    const char* Query = "INSERT INTO retrib_pc_strongest "
        "SET " 
        "ID = %u, "
        "Name = '%s' "
        "ON DUPLICATE KEY UPDATE ID = %u";
       
    Sql_Query(SqlHandle, Query, ID, name, ID);

    Query = "INSERT INTO retrib_pc_stats "
        "SET "
        "ID = %u, "
        "Name = '%s' "
        "ON DUPLICATE KEY UPDATE ID = %u";

    Sql_Query(SqlHandle, Query, ID, name, ID);

    Query = "INSERT INTO retrib_pc "
        "SET "
        "ID = %u "
        "ON DUPLICATE KEY UPDATE ID = %u";

    Sql_Query(SqlHandle, Query, ID, ID);
}

auto CStrongest::IsActive() -> bool
{
    return this->Active;
}

CRetribEvent::CRetribEvent()
{
    SA = new CStrongest();
}

CRetribEvent::~CRetribEvent()
{

}

auto CRetribEvent::InitializeEvents() -> void
{
    SA->LoadData();
}

auto CRetribEvent::DailyGiftUpdate() -> void
{
    const char* Query = 
        "UPDATE retrib_pc_daily AS A "
        "SET HasGift = 0, "
        "Points = (SELECT Points FROM retrib_pc_stats AS C WHERE C.ID = A.ID), "
        "PlayTime = (SELECT playtime FROM chars AS B WHERE B.charid = A.ID);";
    Sql_Query(SqlHandle, Query);

    char Data[1];
    ref<uint8>(&Data, 0) = 0;
    message::send(MSG_UPDATE_EVENT, &Data[0], sizeof(Data), nullptr);
}