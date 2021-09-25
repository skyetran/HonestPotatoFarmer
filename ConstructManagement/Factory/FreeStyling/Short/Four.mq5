#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Short/Four.mqh"

namespace _AnonymousFourLevelNetShortFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetShortFreeStylingConstruct AnonymousFourLevelNetShortFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetShortFreeStylingFactory::FourLevelNetShortFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousFourLevelNetShortFreeStylingConstructNameSpace::AnonymousFourLevelNetShortFreeStylingConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *FourLevelNetShortFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool FourLevelNetShortFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *FourLevelNetShortFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *FourLevelNetShortFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}