#property strict

#include "../../../../ConstructManagement/Factory/Counter/Long/Four.mqh"

namespace _AnonymousFourLevelNetLongCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetLongCounterConstruct AnonymousFourLevelNetLongCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetLongCounterFactory::FourLevelNetLongCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousFourLevelNetLongCounterConstructNameSpace::AnonymousFourLevelNetLongCounterConstruct.GetConstructType(), GetPointer(this));
}