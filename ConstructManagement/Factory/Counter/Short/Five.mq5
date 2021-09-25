#property strict

#include "../../../../ConstructManagement/Factory/Counter/Short/Five.mqh"

namespace _AnonymousFiveLevelNetShortCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetShortCounterConstruct AnonymousFiveLevelNetShortCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetShortCounterFactory::FiveLevelNetShortCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousFiveLevelNetShortCounterConstructNameSpace::AnonymousFiveLevelNetShortCounterConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *FiveLevelNetShortCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool FiveLevelNetShortCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *FiveLevelNetShortCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *FiveLevelNetShortCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}