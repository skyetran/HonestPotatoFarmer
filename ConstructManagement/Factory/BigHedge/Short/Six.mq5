#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Short/Six.mqh"

namespace _AnonymousSixLevelNetShortBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetShortBigHedgeConstruct AnonymousSixLevelNetShortBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetShortBigHedgeFactory::SixLevelNetShortBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousSixLevelNetShortBigHedgeConstructNameSpace::AnonymousSixLevelNetShortBigHedgeConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SixLevelNetShortBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool SixLevelNetShortBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *SixLevelNetShortBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SixLevelNetShortBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}