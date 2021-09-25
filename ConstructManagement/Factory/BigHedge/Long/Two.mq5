#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Long/Two.mqh"

namespace _AnonymousTwoLevelNetLongBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetLongBigHedgeConstruct AnonymousTwoLevelNetLongBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetLongBigHedgeFactory::TwoLevelNetLongBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousTwoLevelNetLongBigHedgeConstructNameSpace::AnonymousTwoLevelNetLongBigHedgeConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *TwoLevelNetLongBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool TwoLevelNetLongBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *TwoLevelNetLongBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *TwoLevelNetLongBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}