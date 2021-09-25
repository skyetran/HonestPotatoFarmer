#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Short/Four.mqh"

namespace _AnonymousFourLevelNetShortBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetShortBigHedgeConstruct AnonymousFourLevelNetShortBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetShortBigHedgeFactory::FourLevelNetShortBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousFourLevelNetShortBigHedgeConstructNameSpace::AnonymousFourLevelNetShortBigHedgeConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *FourLevelNetShortBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool FourLevelNetShortBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *FourLevelNetShortBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *FourLevelNetShortBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}