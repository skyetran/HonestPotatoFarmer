#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Long/Two.mqh"

namespace _AnonymousTwoLevelNetLongBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetLongBigHedgeConstruct AnonymousTwoLevelNetLongBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetLongBigHedgeFactory::TwoLevelNetLongBigHedgeFactory(void) {
   Type = _AnonymousTwoLevelNetLongBigHedgeConstructNameSpace::AnonymousTwoLevelNetLongBigHedgeConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *TwoLevelNetLongBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   int DeathZoneSize = PriceToPointCvt(MathAbs(GetNLevelPrice(InputParameters, LEVEL_TWO) - InputParameters.GetStopLossLevel()));
   int MaxPotentialLossInMinLotPointValue = 4 * IP.GetAverageSpreadInPts(CURRENT_BAR) + 2 * InputParameters.GetIntervalSizeInPts() + 4 * DeathZoneSize;
   return new ConstructPreCheckInfo(0.04, 0.04, MaxPotentialLossInMinLotPointValue);
}

bool TwoLevelNetLongBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsTwoLevel(InputParameters)                                        &&
          IsNetLong(InputParameters)                                         &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *TwoLevelNetLongBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   TwoLevelNetLongBigHedgeConstruct *NewConstruct = new TwoLevelNetLongBigHedgeConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *TwoLevelNetLongBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO), GetNLevelPrice(InputParameters, LEVEL_ZERO) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(0.02));
   
   ExecutionBoundary *UpsideHedgeTakeProfitBoundary = new ExecutionBoundary(GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)) - InputParameters.GetIntervalSizeInPrice(), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddOneTimeRequest(UpsideHedgeTakeProfitBoundary, SellLimitOrderRequest(0.02, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(MIN_LOT_SIZE));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(MIN_LOT_SIZE));
   
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))));
   
   //--- Retracement Entry Order
   ExecutionBoundary *RetracementEntryBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) , GetNLevelPrice(InputParameters, LEVEL_ZERO) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary1, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary1, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)), GetNLevelPrice(InputParameters, LEVEL_ZERO)));

   ExecutionBoundary *RetracementEntryBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetNLevelPrice(InputParameters, LEVEL_ZERO));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary2, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary2, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)), GetNLevelPrice(InputParameters, LEVEL_ONE)));
   
   //--- Stop Loss Order
   ExecutionBoundary *OutOfBoundStopLossBoundary = new ExecutionBoundary(GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)) - InputParameters.GetIntervalSizeInPrice(), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(0.02, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())), GetNLevelPrice(InputParameters, LEVEL_TWO));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(0.04, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())));
   
   return FullTradePool;
}

namespace _AnonymousTwoLevelNetLongBigHedgeFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   TwoLevelNetLongBigHedgeFactory AnonymousTwoLevelNetLongBigHedgeFactory;
}