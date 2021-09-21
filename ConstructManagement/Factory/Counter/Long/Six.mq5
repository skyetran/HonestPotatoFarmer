#property strict

#include "../../../../ConstructManagement/Factory/Counter/Long/Six.mqh"

namespace _AnonymousSixLevelNetLongCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetLongCounterConstruct AnonymousSixLevelNetLongCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetLongCounterFactory::SixLevelNetLongCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousSixLevelNetLongCounterConstructNameSpace::AnonymousSixLevelNetLongCounterConstruct.GetConstructType(), GetPointer(this));
}