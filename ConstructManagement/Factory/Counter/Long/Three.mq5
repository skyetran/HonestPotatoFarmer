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

//--- Operations
ConstructPreCheckInfo *ThreeLevelNetLongCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool ThreeLevelNetLongCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *ThreeLevelNetLongCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *ThreeLevelNetLongCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}