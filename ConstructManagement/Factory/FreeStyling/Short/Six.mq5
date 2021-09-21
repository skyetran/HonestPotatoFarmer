#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Short/Six.mqh"

namespace _AnonymousSixLevelNetShortFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetShortFreeStylingConstruct AnonymousSixLevelNetShortFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetShortFreeStylingFactory::SixLevelNetShortFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousSixLevelNetShortFreeStylingConstructNameSpace::AnonymousSixLevelNetShortFreeStylingConstruct.GetConstructType(), GetPointer(this));
}