#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Long/Three.mqh"

namespace _AnonymousThreeLevelNetLongBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetLongBigHedgeConstruct AnonymousThreeLevelNetLongBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetLongBigHedgeFactory::ThreeLevelNetLongBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousThreeLevelNetLongBigHedgeConstructNameSpace::AnonymousThreeLevelNetLongBigHedgeConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *ThreeLevelNetLongBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool ThreeLevelNetLongBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *ThreeLevelNetLongBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *ThreeLevelNetLongBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}