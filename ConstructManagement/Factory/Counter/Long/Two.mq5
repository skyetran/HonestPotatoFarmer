#property strict

#include "../../../../ConstructManagement/Factory/Counter/Long/Two.mqh"

namespace _AnonymousTwoLevelNetLongCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetLongCounterConstruct AnonymousTwoLevelNetLongCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetLongCounterFactory::TwoLevelNetLongCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousTwoLevelNetLongCounterConstructNameSpace::AnonymousTwoLevelNetLongCounterConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *TwoLevelNetLongCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool TwoLevelNetLongCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *TwoLevelNetLongCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *TwoLevelNetLongCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}