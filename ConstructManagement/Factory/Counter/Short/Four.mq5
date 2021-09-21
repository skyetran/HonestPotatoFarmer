#property strict

#include "../../../../ConstructManagement/Factory/Counter/Short/Four.mqh"

namespace _AnonymousFourLevelNetShortCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetShortCounterConstruct AnonymousFourLevelNetShortCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetShortCounterFactory::FourLevelNetShortCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousFourLevelNetShortCounterConstructNameSpace::AnonymousFourLevelNetShortCounterConstruct.GetConstructType(), GetPointer(this));
}