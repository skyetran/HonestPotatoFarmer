#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Long/Six.mqh"

namespace _AnonymousSixLevelNetLongFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetLongFreeStylingConstruct AnonymousSixLevelNetLongFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetLongFreeStylingFactory::SixLevelNetLongFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousSixLevelNetLongFreeStylingConstructNameSpace::AnonymousSixLevelNetLongFreeStylingConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SixLevelNetLongFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool SixLevelNetLongFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *SixLevelNetLongFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SixLevelNetLongFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}