#property strict

#include "../../../../ConstructManagement/Factory/Counter/Short/Six.mqh"

namespace _AnonymousSixLevelNetShortCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetShortCounterConstruct AnonymousSixLevelNetShortCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetShortCounterFactory::SixLevelNetShortCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousSixLevelNetShortCounterConstructNameSpace::AnonymousSixLevelNetShortCounterConstruct.GetConstructType(), GetPointer(this));
}