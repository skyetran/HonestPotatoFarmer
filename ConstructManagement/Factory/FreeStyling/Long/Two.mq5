#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Long/Two.mqh"

namespace _AnonymousTwoLevelNetLongFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetLongFreeStylingConstruct AnonymousTwoLevelNetLongFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetLongFreeStylingFactory::TwoLevelNetLongFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousTwoLevelNetLongFreeStylingConstructNameSpace::AnonymousTwoLevelNetLongFreeStylingConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *TwoLevelNetLongFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool TwoLevelNetLongFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *TwoLevelNetLongFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *TwoLevelNetLongFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}