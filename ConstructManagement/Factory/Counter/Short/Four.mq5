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

//--- Operations
ConstructPreCheckInfo *FourLevelNetShortCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool FourLevelNetShortCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *FourLevelNetShortCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *FourLevelNetShortCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}