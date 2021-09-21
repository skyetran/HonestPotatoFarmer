#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Long/Four.mqh"

namespace _AnonymousFourLevelNetLongBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetLongBigHedgeConstruct AnonymousFourLevelNetLongBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetLongBigHedgeFactory::FourLevelNetLongBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousFourLevelNetLongBigHedgeConstructNameSpace::AnonymousFourLevelNetLongBigHedgeConstruct.GetConstructType(), GetPointer(this));
}