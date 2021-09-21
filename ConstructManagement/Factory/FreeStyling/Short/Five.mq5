#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Short/Five.mqh"

namespace _AnonymousFiveLevelNetShortFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetShortFreeStylingConstruct AnonymousFiveLevelNetShortFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetShortFreeStylingFactory::FiveLevelNetShortFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousFiveLevelNetShortFreeStylingConstructNameSpace::AnonymousFiveLevelNetShortFreeStylingConstruct.GetConstructType(), GetPointer(this));
}