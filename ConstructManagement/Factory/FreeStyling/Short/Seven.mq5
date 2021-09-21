#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Short/Seven.mqh"

namespace _AnonymousSevenLevelNetShortFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetShortFreeStylingConstruct AnonymousSevenLevelNetShortFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetShortFreeStylingFactory::SevenLevelNetShortFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousSevenLevelNetShortFreeStylingConstructNameSpace::AnonymousSevenLevelNetShortFreeStylingConstruct.GetConstructType(), GetPointer(this));
}