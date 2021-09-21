#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Long/Four.mqh"

namespace _AnonymousFourLevelNetLongFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetLongFreeStylingConstruct AnonymousFourLevelNetLongFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetLongFreeStylingFactory::FourLevelNetLongFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousFourLevelNetLongFreeStylingConstructNameSpace::AnonymousFourLevelNetLongFreeStylingConstruct.GetConstructType(), GetPointer(this));
}