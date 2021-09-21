#property strict

#include "../../../../ConstructManagement/Factory/Counter/Short/Three.mqh"

namespace _AnonymousThreeLevelNetShortCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetShortCounterConstruct AnonymousThreeLevelNetShortCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetShortCounterFactory::ThreeLevelNetShortCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousThreeLevelNetShortCounterConstructNameSpace::AnonymousThreeLevelNetShortCounterConstruct.GetConstructType(), GetPointer(this));
}