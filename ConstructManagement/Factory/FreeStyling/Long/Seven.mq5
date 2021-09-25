#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Long/Seven.mqh"

namespace _AnonymousSevenLevelNetLongFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetLongFreeStylingConstruct AnonymousSevenLevelNetLongFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetLongFreeStylingFactory::SevenLevelNetLongFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousSevenLevelNetLongFreeStylingConstructNameSpace::AnonymousSevenLevelNetLongFreeStylingConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SevenLevelNetLongFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool SevenLevelNetLongFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *SevenLevelNetLongFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SevenLevelNetLongFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}