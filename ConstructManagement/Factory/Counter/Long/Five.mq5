#property strict

#include "../../../../ConstructManagement/Factory/Counter/Long/Five.mqh"

namespace _AnonymousFiveLevelNetLongCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetLongCounterConstruct AnonymousFiveLevelNetLongCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetLongCounterFactory::FiveLevelNetLongCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousFiveLevelNetLongCounterConstructNameSpace::AnonymousFiveLevelNetLongCounterConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *FiveLevelNetLongCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool FiveLevelNetLongCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *FiveLevelNetLongCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *FiveLevelNetLongCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}