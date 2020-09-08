/**************************************************************************
 Retrib Header File
**************************************************************************/

#ifndef _RETRIB_PLAYER_HUNTER_H
#define _RETRIB_PLAYER_HUNTER_H

struct Hunt_t
{
    std::string Name   = "";
    std::string DBName = "";
    std::string ZNText = "";
    uint32  MID   = 0;
    uint8  Gender = 0;
    uint16 XP     = 0;
    uint16 Gil    = 0;
    uint16 Zone   = 0;
    bool   Killed = false;
};

class CRetribPlayerHunter
{
    public:

    CRetribPlayerHunter(uint16 ID);
    ~CRetribPlayerHunter();

    uint16 ID;
    Hunt_t Hunt;

    auto LoadHunt               (void)   -> void;
    auto GetNewHunt             (uint8)  -> Hunt_t;
    auto GetHunt                (void)   -> Hunt_t;
    auto HasHunt                (void)   -> bool;
    auto DeleteHunt             (void)   -> void;
    auto GetHuntTarget          (void)   -> std::string;
    auto HasKilledTarget        (void)   -> bool;
    auto KillHuntTarget         (void)   -> uint16;
};

#endif // _RETRIB_PLAYER_HUNTER_H
