#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Long/Seven.mqh"

namespace _AnonymousSevenLevelNetLongBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetLongBigHedgeConstruct AnonymousSevenLevelNetLongBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetLongBigHedgeFactory::SevenLevelNetLongBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousSevenLevelNetLongBigHedgeConstructNameSpace::AnonymousSevenLevelNetLongBigHedgeConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SevenLevelNetLongBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool SevenLevelNetLongBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *SevenLevelNetLongBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SevenLevelNetLongBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}