#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Long/Five.mqh"

namespace _AnonymousFiveLevelNetLongBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetLongBigHedgeConstruct AnonymousFiveLevelNetLongBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetLongBigHedgeFactory::FiveLevelNetLongBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousFiveLevelNetLongBigHedgeConstructNameSpace::AnonymousFiveLevelNetLongBigHedgeConstruct.GetConstructType(), GetPointer(this));
}