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

//--- Operations
ConstructPreCheckInfo *SixLevelNetLongCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool SixLevelNetLongCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *SixLevelNetLongCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SixLevelNetLongCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}