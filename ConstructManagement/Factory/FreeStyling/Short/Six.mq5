#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Short/Six.mqh"

namespace _AnonymousSixLevelNetShortFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetShortFreeStylingConstruct AnonymousSixLevelNetShortFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetShortFreeStylingFactory::SixLevelNetShortFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousSixLevelNetShortFreeStylingConstructNameSpace::AnonymousSixLevelNetShortFreeStylingConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SixLevelNetShortFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool SixLevelNetShortFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *SixLevelNetShortFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SixLevelNetShortFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}