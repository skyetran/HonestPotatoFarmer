#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Long/Six.mqh"

namespace _AnonymousSixLevelNetLongFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetLongFreeStylingConstruct AnonymousSixLevelNetLongFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetLongFreeStylingFactory::SixLevelNetLongFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousSixLevelNetLongFreeStylingConstructNameSpace::AnonymousSixLevelNetLongFreeStylingConstruct.GetConstructType(), GetPointer(this));
}