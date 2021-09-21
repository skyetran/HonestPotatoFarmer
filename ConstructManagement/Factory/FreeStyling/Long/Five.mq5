#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Long/Five.mqh"

namespace _AnonymousFiveLevelNetLongFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetLongFreeStylingConstruct AnonymousFiveLevelNetLongFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetLongFreeStylingFactory::FiveLevelNetLongFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousFiveLevelNetLongFreeStylingConstructNameSpace::AnonymousFiveLevelNetLongFreeStylingConstruct.GetConstructType(), GetPointer(this));
}