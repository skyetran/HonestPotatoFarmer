#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Long/Seven.mqh"

namespace _AnonymousSevenLevelNetLongBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetLongBigHedgeConstruct AnonymousSevenLevelNetLongBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetLongBigHedgeFactory::SevenLevelNetLongBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousSevenLevelNetLongBigHedgeConstructNameSpace::AnonymousSevenLevelNetLongBigHedgeConstruct.GetConstructType(), GetPointer(this));
}