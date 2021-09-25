#property strict

#include "../../../../ConstructManagement/Factory/Counter/Short/Two.mqh"

namespace _AnonymousTwoLevelNetShortCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetShortCounterConstruct AnonymousTwoLevelNetShortCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetShortCounterFactory::TwoLevelNetShortCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousTwoLevelNetShortCounterConstructNameSpace::AnonymousTwoLevelNetShortCounterConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *TwoLevelNetShortCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool TwoLevelNetShortCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *TwoLevelNetShortCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *TwoLevelNetShortCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}