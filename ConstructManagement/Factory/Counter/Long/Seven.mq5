#property strict

#include "../../../../ConstructManagement/Factory/Counter/Long/Seven.mqh"

namespace _AnonymousSevenLevelNetLongCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetLongCounterConstruct AnonymousSevenLevelNetLongCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetLongCounterFactory::SevenLevelNetLongCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousSevenLevelNetLongCounterConstructNameSpace::AnonymousSevenLevelNetLongCounterConstruct.GetConstructType(), GetPointer(this));
}