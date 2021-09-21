#property strict

#include "../../../../ConstructManagement/Factory/Counter/Short/Seven.mqh"

namespace _AnonymousSevenLevelNetShortCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetShortCounterConstruct AnonymousSevenLevelNetShortCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetShortCounterFactory::SevenLevelNetShortCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousSevenLevelNetShortCounterConstructNameSpace::AnonymousSevenLevelNetShortCounterConstruct.GetConstructType(), GetPointer(this));
}