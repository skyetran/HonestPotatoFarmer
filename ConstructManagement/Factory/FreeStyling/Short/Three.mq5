#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Short/Three.mqh"

namespace _AnonymousThreeLevelNetShortFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetShortFreeStylingConstruct AnonymousThreeLevelNetShortFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetShortFreeStylingFactory::ThreeLevelNetShortFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousThreeLevelNetShortFreeStylingConstructNameSpace::AnonymousThreeLevelNetShortFreeStylingConstruct.GetConstructType(), GetPointer(this));
}