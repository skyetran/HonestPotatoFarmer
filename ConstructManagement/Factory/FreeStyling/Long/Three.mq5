#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Long/Three.mqh"

namespace _AnonymousThreeLevelNetLongFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetLongFreeStylingConstruct AnonymousThreeLevelNetLongFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetLongFreeStylingFactory::ThreeLevelNetLongFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousThreeLevelNetLongFreeStylingConstructNameSpace::AnonymousThreeLevelNetLongFreeStylingConstruct.GetConstructType(), GetPointer(this));
}