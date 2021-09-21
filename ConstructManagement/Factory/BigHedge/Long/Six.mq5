#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Long/Six.mqh"

namespace _AnonymousSixLevelNetLongBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetLongBigHedgeConstruct AnonymousSixLevelNetLongBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetLongBigHedgeFactory::SixLevelNetLongBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousSixLevelNetLongBigHedgeConstructNameSpace::AnonymousSixLevelNetLongBigHedgeConstruct.GetConstructType(), GetPointer(this));
}