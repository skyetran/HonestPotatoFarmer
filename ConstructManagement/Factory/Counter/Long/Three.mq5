#property strict

#include "../../../../ConstructManagement/Factory/Counter/Long/Three.mqh"

namespace _AnonymousThreeLevelNetLongCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetLongCounterConstruct AnonymousThreeLevelNetLongCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetLongCounterFactory::ThreeLevelNetLongCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousThreeLevelNetLongCounterConstructNameSpace::AnonymousThreeLevelNetLongCounterConstruct.GetConstructType(), GetPointer(this));
}