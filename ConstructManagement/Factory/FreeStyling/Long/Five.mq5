#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Long/Five.mqh"

namespace _AnonymousFiveLevelNetLongFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetLongFreeStylingConstruct AnonymousFiveLevelNetLongFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetLongFreeStylingFactory::FiveLevelNetLongFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousFiveLevelNetLongFreeStylingConstructNameSpace::AnonymousFiveLevelNetLongFreeStylingConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *FiveLevelNetLongFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool FiveLevelNetLongFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *FiveLevelNetLongFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *FiveLevelNetLongFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}