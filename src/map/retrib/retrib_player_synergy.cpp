/**************************************************************************
 Retrib Synergy Class Methods
**************************************************************************/

#include "../utils/charutils.h"
#include <string>
#include "retrib_player_synergy.h"

CRetribPlayerSynergy::CRetribPlayerSynergy(uint16 ID)
{
    this->ID = ID;
    this->Tier = 0;
    this->Jail = false;
    memset(&this->Skill, 0, sizeof(this->Skill));
    memset(&this->Items, 0, sizeof(this->Items));
    this->Session = new CSynergySession();
}
CRetribPlayerSynergy::~CRetribPlayerSynergy()
{
    
}
auto CRetribPlayerSynergy::GetSkill(uint8 Tier) -> uint16
{
    return this->Skill[Tier];
}
auto CRetribPlayerSynergy::AddSkill(uint8 Tier) -> void
{
    this->Skill[Tier]++;
    std::string TierCol = "S" + std::to_string(Tier);
    const char* Query = "UPDATE retrib_pc_synergy SET %s = %s + 1 WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, TierCol, TierCol, this->ID);
}
auto CRetribPlayerSynergy::SetSkill(uint8 Tier, uint16 Amount) -> void
{
    this->Skill[Tier] = Amount;
}
auto CRetribPlayerSynergy::GetItems(uint8 Tier) -> uint16
{
    return this->Items[Tier];
}
auto CRetribPlayerSynergy::AddItems(uint8 Tier, uint8 Amount) -> void
{
    this->Items[Tier] += Amount;
    std::string TierCol = "I" + std::to_string(Tier);
    const char* Query = "UPDATE retrib_pc_synergy SET %s = %s + %u WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, TierCol, TierCol, Amount, this->ID);
}
auto CRetribPlayerSynergy::SetItems(uint8 Tier, uint16 Amount) -> void
{
    this->Items[Tier] = Amount;
}
auto CRetribPlayerSynergy::DelItems(uint8 Tier, uint8 Amount) -> void
{
    this->Items[Tier] -= Amount;
    std::string TierCol = "I" + std::to_string(Tier);
    const char* Query = "UPDATE retrib_pc_synergy SET %s = %s - %u WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, TierCol, TierCol, Amount, this->ID);
}
auto CRetribPlayerSynergy::GetTier(void) -> uint8
{
    return this->Tier;
}
auto CRetribPlayerSynergy::AddTier(void) -> void
{
    this->Tier++;
    const char* Query = "UPDATE retrib_pc_synergy SET Cap = Cap + 1 WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, this->ID);
}
auto CRetribPlayerSynergy::SetTier(uint8 Tier) -> void
{
    this->Tier = Tier;
}
auto CRetribPlayerSynergy::IsInJail(void) -> bool
{
    return this->Jail;
}
auto CRetribPlayerSynergy::SetJail(bool InJail) -> void
{
    this->Jail = InJail;
    const char* Query = "UPDATE retrib_pc_synergy SET Jail = %u WHERE ID = %u;";
    Sql_Query(SqlHandle, Query, InJail ? 1 : 0, this->ID);
}

CSynergySession::CSynergySession()
{
    this->Clear();
}
CSynergySession::~CSynergySession()
{
}
auto CSynergySession::IsReady(void) -> bool
{
    return this->Ready;
}
auto CSynergySession::SetReady(bool Ready) -> void
{
    this->Ready = Ready;
}
auto CSynergySession::GetConsult(void) -> uint8
{
    return this->Consult;
}
auto CSynergySession::SetConsult(uint8 Consult) -> void
{
    this->Consult = Consult;
}
auto CSynergySession::GetTier(void) -> uint8
{
    return this->Tier;
}
auto CSynergySession::SetTier(uint8 Tier) -> void
{
    this->Tier = Tier;
}
auto CSynergySession::GetItem(void) -> uint16
{
    return this->Item;
}
auto CSynergySession::SetItem(uint16 ID) -> void
{
    this->Item = ID;
}
auto CSynergySession::GetGil(void) -> uint32
{
    return this->Gil;
}
auto CSynergySession::SetGil(uint32 Amount) -> void
{
    this->Gil = Amount;
}
auto CSynergySession::GetOption(uint8 O) -> uint8
{
    uint8 Option = 0;
    switch (O)
    {
        case 1: Option = this->O1; break;
        case 2: Option = this->O2; break;
        case 3: Option = this->O3; break;
        case 4: Option = this->O4; break;
    }
    return Option;
}
auto CSynergySession::SetOption(uint8 O, uint8 Option) -> void
{
    switch (O)
    {
        case 1: this->O1 = Option; break;
        case 2: this->O2 = Option; break;
        case 3: this->O3 = Option; break;
        case 4: this->O4 = Option; break;
    }
}
auto CSynergySession::GetNPC(void) -> uint32
{
    return this->NPC;
}
auto CSynergySession::SetNPC(uint32 NPCID) -> void
{
    this->NPC = NPCID;
}
auto CSynergySession::Clear(void) -> void
{
    this->NPC = 0;
    this->Ready = false;
    this->Consult = 0;
    this->Tier = 0;
    this->Item = 0;
    this->Gil = 0;
    this->O1 = 0;
    this->O2 = 0;
    this->O3 = 0;
    this->O4 = 0;
}