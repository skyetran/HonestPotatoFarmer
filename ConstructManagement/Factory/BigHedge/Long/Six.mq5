#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Long/Six.mqh"

namespace _AnonymousSixLevelNetLongBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetLongBigHedgeConstruct AnonymousSixLevelNetLongBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetLongBigHedgeFactory::SixLevelNetLongBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousSixLevelNetLongBigHedgeConstructNameSpace::AnonymousSixLevelNetLongBigHedgeConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SixLevelNetLongBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool SixLevelNetLongBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *SixLevelNetLongBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SixLevelNetLongBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}