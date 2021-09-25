#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Long/Four.mqh"

namespace _AnonymousFourLevelNetLongBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FourLevelNetLongBigHedgeConstruct AnonymousFourLevelNetLongBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
FourLevelNetLongBigHedgeFactory::FourLevelNetLongBigHedgeFactory(void) {
   Construct::RegisterFactory(_AnonymousFourLevelNetLongBigHedgeConstructNameSpace::AnonymousFourLevelNetLongBigHedgeConstruct.GetConstructType(), GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *FourLevelNetLongBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   int DeathZoneSize = PriceToPointCvt(MathAbs(GetNLevelPrice(InputParameters, LEVEL_FIVE) - InputParameters.GetStopLossLevel()));
   int MaxPotentialLossInMinLotPointValue = 8 * IP.GetAverageSpreadInPts(CURRENT_BAR) + 12 * InputParameters.GetIntervalSizeInPts() + 8 * DeathZoneSize;
   return new ConstructPreCheckInfo(0.08, 0.08, MaxPotentialLossInMinLotPointValue);
}

bool FourLevelNetLongBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return false;
}

Construct *FourLevelNetLongBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return NULL;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *FourLevelNetLongBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   return FullTradePool;
}