#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Short/Two.mqh"

namespace _AnonymousTwoLevelNetShortBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetShortBigHedgeConstruct AnonymousTwoLevelNetShortBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetShortBigHedgeFactory::TwoLevelNetShortBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousTwoLevelNetShortBigHedgeConstructNameSpace::AnonymousTwoLevelNetShortBigHedgeConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *TwoLevelNetShortBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool TwoLevelNetShortBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *TwoLevelNetShortBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *TwoLevelNetShortBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}