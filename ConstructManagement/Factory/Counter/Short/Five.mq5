#property strict

#include "../../../../ConstructManagement/Factory/Counter/Short/Five.mqh"

namespace _AnonymousFiveLevelNetShortCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetShortCounterConstruct AnonymousFiveLevelNetShortCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetShortCounterFactory::FiveLevelNetShortCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousFiveLevelNetShortCounterConstructNameSpace::AnonymousFiveLevelNetShortCounterConstruct.GetConstructType(), GetPointer(this));
}