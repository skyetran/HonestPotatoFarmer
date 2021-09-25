#property strict

#include "../../../../ConstructManagement/Factory/Counter/Long/Four.mqh"

namespace _AnonymousFourLevelNetLongCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetLongCounterConstruct AnonymousFourLevelNetLongCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetLongCounterFactory::FourLevelNetLongCounterFactory(void) {
   Construct::RegisterFactory(_AnonymousFourLevelNetLongCounterConstructNameSpace::AnonymousFourLevelNetLongCounterConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *FourLevelNetLongCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool FourLevelNetLongCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *FourLevelNetLongCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *FourLevelNetLongCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}