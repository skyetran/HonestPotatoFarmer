#property strict

#include "../../../../ConstructManagement/Factory/Counter/Long/Seven.mqh"

namespace _AnonymousSevenLevelNetLongCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetLongCounterConstruct AnonymousSevenLevelNetLongCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetLongCounterFactory::SevenLevelNetLongCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousSevenLevelNetLongCounterConstructNameSpace::AnonymousSevenLevelNetLongCounterConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SevenLevelNetLongCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool SevenLevelNetLongCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *SevenLevelNetLongCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SevenLevelNetLongCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}