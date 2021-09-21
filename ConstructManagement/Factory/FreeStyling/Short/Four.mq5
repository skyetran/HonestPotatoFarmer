#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Short/Four.mqh"

namespace _AnonymousFourLevelNetShortFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetShortFreeStylingConstruct AnonymousFourLevelNetShortFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetShortFreeStylingFactory::FourLevelNetShortFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousFourLevelNetShortFreeStylingConstructNameSpace::AnonymousFourLevelNetShortFreeStylingConstruct.GetConstructType(), GetPointer(this));
}