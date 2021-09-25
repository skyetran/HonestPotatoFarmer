#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Short/Five.mqh"

namespace _AnonymousFiveLevelNetShortFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetShortFreeStylingConstruct AnonymousFiveLevelNetShortFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetShortFreeStylingFactory::FiveLevelNetShortFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousFiveLevelNetShortFreeStylingConstructNameSpace::AnonymousFiveLevelNetShortFreeStylingConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *FiveLevelNetShortFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool FiveLevelNetShortFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *FiveLevelNetShortFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *FiveLevelNetShortFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}