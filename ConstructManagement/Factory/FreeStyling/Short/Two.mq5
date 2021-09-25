#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Short/Two.mqh"

namespace _AnonymousTwoLevelNetShortFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetShortFreeStylingConstruct AnonymousTwoLevelNetShortFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetShortFreeStylingFactory::TwoLevelNetShortFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousTwoLevelNetShortFreeStylingConstructNameSpace::AnonymousTwoLevelNetShortFreeStylingConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *TwoLevelNetShortFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool TwoLevelNetShortFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *TwoLevelNetShortFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *TwoLevelNetShortFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}