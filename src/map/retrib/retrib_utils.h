#ifndef _RETRIB_UTILS_H
#define _RETRIB_UTILS_H

#include "../../common/cbasetypes.h"
#include "../../common/mmo.h"
#include "../entities/baseentity.h"
#include "../entities/charentity.h"

namespace RetribUtils
{
    auto UpdatePosition(CCharEntity*, CBaseEntity*) -> void;
    auto SaveZonePoint(CCharEntity*)                -> void;
    auto SavePathPoint(CCharEntity*)                -> void;
    auto SendTo(CCharEntity*, uint16)               -> void;
}; // RetribUtils

#endif // _RETRIB_UTILS_H