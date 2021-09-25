#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Short/Five.mqh"

namespace _AnonymousFiveLevelNetShortBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetShortBigHedgeConstruct AnonymousFiveLevelNetShortBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetShortBigHedgeFactory::FiveLevelNetShortBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousFiveLevelNetShortBigHedgeConstructNameSpace::AnonymousFiveLevelNetShortBigHedgeConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *FiveLevelNetShortBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool FiveLevelNetShortBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *FiveLevelNetShortBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *FiveLevelNetShortBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}