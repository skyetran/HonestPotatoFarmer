#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Long/Seven.mqh"

namespace _AnonymousSevenLevelNetLongFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetLongFreeStylingConstruct AnonymousSevenLevelNetLongFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetLongFreeStylingFactory::SevenLevelNetLongFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousSevenLevelNetLongFreeStylingConstructNameSpace::AnonymousSevenLevelNetLongFreeStylingConstruct.GetConstructType(), GetPointer(this));
}