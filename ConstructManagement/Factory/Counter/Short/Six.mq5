#property strict

#include "../../../../ConstructManagement/Factory/Counter/Short/Six.mqh"

namespace _AnonymousSixLevelNetShortCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetShortCounterConstruct AnonymousSixLevelNetShortCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetShortCounterFactory::SixLevelNetShortCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousSixLevelNetShortCounterConstructNameSpace::AnonymousSixLevelNetShortCounterConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SixLevelNetShortCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool SixLevelNetShortCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *SixLevelNetShortCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SixLevelNetShortCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}