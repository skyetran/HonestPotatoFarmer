#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Long/Four.mqh"

namespace _AnonymousFourLevelNetLongFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetLongFreeStylingConstruct AnonymousFourLevelNetLongFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetLongFreeStylingFactory::FourLevelNetLongFreeStylingFactory(void) {
   Construct::RegisterFactory(_AnonymousFourLevelNetLongFreeStylingConstructNameSpace::AnonymousFourLevelNetLongFreeStylingConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *FourLevelNetLongFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return NULL;
}

bool FourLevelNetLongFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *FourLevelNetLongFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *FourLevelNetLongFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}