#property strict

#include "../../../../ConstructManagement/Factory/Counter/Long/Five.mqh"

namespace _AnonymousFiveLevelNetLongCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetLongCounterConstruct AnonymousFiveLevelNetLongCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetLongCounterFactory::FiveLevelNetLongCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousFiveLevelNetLongCounterConstructNameSpace::AnonymousFiveLevelNetLongCounterConstruct.GetConstructType(), GetPointer(this));
}