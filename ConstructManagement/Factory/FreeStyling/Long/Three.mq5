#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Long/Three.mqh"

namespace _AnonymousThreeLevelNetLongFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetLongFreeStylingConstruct AnonymousThreeLevelNetLongFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetLongFreeStylingFactory::ThreeLevelNetLongFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousThreeLevelNetLongFreeStylingConstructNameSpace::AnonymousThreeLevelNetLongFreeStylingConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *ThreeLevelNetLongFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool ThreeLevelNetLongFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *ThreeLevelNetLongFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *ThreeLevelNetLongFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}