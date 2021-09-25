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

//--- Operations
ConstructPreCheckInfo *ThreeLevelNetShortCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool ThreeLevelNetShortCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *ThreeLevelNetShortCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *ThreeLevelNetShortCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}