#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Long/Three.mqh"

namespace _AnonymousThreeLevelNetLongBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetLongBigHedgeConstruct AnonymousThreeLevelNetLongBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetLongBigHedgeFactory::ThreeLevelNetLongBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousThreeLevelNetLongBigHedgeConstructNameSpace::AnonymousThreeLevelNetLongBigHedgeConstruct.GetConstructType(), GetPointer(this));
}