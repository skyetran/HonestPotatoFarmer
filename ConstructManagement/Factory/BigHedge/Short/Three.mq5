#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Short/Three.mqh"

namespace _AnonymousThreeLevelNetShortBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetShortBigHedgeConstruct AnonymousThreeLevelNetShortBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetShortBigHedgeFactory::ThreeLevelNetShortBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousThreeLevelNetShortBigHedgeConstructNameSpace::AnonymousThreeLevelNetShortBigHedgeConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *ThreeLevelNetShortBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool ThreeLevelNetShortBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *ThreeLevelNetShortBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *ThreeLevelNetShortBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}