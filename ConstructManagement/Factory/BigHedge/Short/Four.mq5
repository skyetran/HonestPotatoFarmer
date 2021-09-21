#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Short/Four.mqh"

namespace _AnonymousFourLevelNetShortBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetShortBigHedgeConstruct AnonymousFourLevelNetShortBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetShortBigHedgeFactory::FourLevelNetShortBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousFourLevelNetShortBigHedgeConstructNameSpace::AnonymousFourLevelNetShortBigHedgeConstruct.GetConstructType(), GetPointer(this));
}