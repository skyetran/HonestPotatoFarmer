#property strict

#include "../../../../ConstructManagement/Factory/Counter/Short/Seven.mqh"

namespace _AnonymousSevenLevelNetShortCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetShortCounterConstruct AnonymousSevenLevelNetShortCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetShortCounterFactory::SevenLevelNetShortCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousSevenLevelNetShortCounterConstructNameSpace::AnonymousSevenLevelNetShortCounterConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SevenLevelNetShortCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool SevenLevelNetShortCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *SevenLevelNetShortCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SevenLevelNetShortCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}