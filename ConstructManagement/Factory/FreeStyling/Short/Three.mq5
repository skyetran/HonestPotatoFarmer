#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Short/Three.mqh"

namespace _AnonymousThreeLevelNetShortFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetShortFreeStylingConstruct AnonymousThreeLevelNetShortFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetShortFreeStylingFactory::ThreeLevelNetShortFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousThreeLevelNetShortFreeStylingConstructNameSpace::AnonymousThreeLevelNetShortFreeStylingConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *ThreeLevelNetShortFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool ThreeLevelNetShortFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *ThreeLevelNetShortFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *ThreeLevelNetShortFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}