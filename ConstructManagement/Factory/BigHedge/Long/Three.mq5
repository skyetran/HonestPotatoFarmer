#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Long/Three.mqh"

namespace _AnonymousThreeLevelNetLongBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetLongBigHedgeConstruct AnonymousThreeLevelNetLongBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetLongBigHedgeFactory::ThreeLevelNetLongBigHedgeFactory(void) {
   Type = _AnonymousThreeLevelNetLongBigHedgeConstructNameSpace::AnonymousThreeLevelNetLongBigHedgeConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *ThreeLevelNetLongBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   int DeathZoneSize = PriceToPointCvt(MathAbs(GetNLevelPrice(InputParameters, LEVEL_THREE) - InputParameters.GetStopLossLevel()));
   int MaxPotentialLossInMinLotPointValue = 6 * IP.GetAverageSpreadInPts(CURRENT_BAR) + 6 * InputParameters.GetIntervalSizeInPts() + 6 * DeathZoneSize;
   return new ConstructPreCheckInfo(0.06, 0.06, MaxPotentialLossInMinLotPointValue);
}

bool ThreeLevelNetLongBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsThreeLevel(InputParameters)                                      &&
          IsNetLong(InputParameters)                                         &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *ThreeLevelNetLongBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   ThreeLevelNetLongBigHedgeConstruct *NewConstruct = new ThreeLevelNetLongBigHedgeConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *ThreeLevelNetLongBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO), GetNLevelPrice(InputParameters, LEVEL_ZERO) + PMHP.GetSlippageInPrice());
   FullTradePool.AddRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(0.03));
   FullTradePool.AddRequest(BaseEntryBoundary, SellRawMarketOrderRequest(MIN_LOT_SIZE));
   FullTradePool.AddRequest(BaseEntryBoundary, SellRawMarketOrderRequest(MIN_LOT_SIZE));
   FullTradePool.AddRequest(BaseEntryBoundary, SellRawMarketOrderRequest(MIN_LOT_SIZE));
   
   //--- Retracement Entry Order
   ExecutionBoundary *RetracementEntryBoundary1 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)))  , GetNLevelPrice(InputParameters, LEVEL_ZERO));
   FullTradePool.AddRequest(RetracementEntryBoundary1, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));

   ExecutionBoundary *RetracementEntryBoundary2 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)))  , GetNLevelPrice(InputParameters, LEVEL_ONE));
   FullTradePool.AddRequest(RetracementEntryBoundary2, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))));
   
   ExecutionBoundary *RetracementEntryBoundary3 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE))), GetNLevelPrice(InputParameters, LEVEL_TWO));
   FullTradePool.AddRequest(RetracementEntryBoundary3, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE))));
   
   //--- Counter Entry Order
   ExecutionBoundary *CounterEntryBoundary = new ExecutionBoundary(InputParameters.GetStopLossLevel(), InputParameters.GetApexLevel());
   FullTradePool.AddRequest(CounterEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))  , GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRequest(CounterEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))  , GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRequest(CounterEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)), GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   
   //--- Take Profit Order
   ExecutionBoundary *OutOfBoundTakeProfitBoundary = new ExecutionBoundary(InputParameters.GetApexLevel(), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddRequest(OutOfBoundTakeProfitBoundary, SellLimitOrderRequest(0.03, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   
   ExecutionBoundary *RetracementTakeProfitBoundary = new ExecutionBoundary(InputParameters.GetStopLossLevel(), InputParameters.GetApexLevel());
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))  , GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))  , GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)), GetNLevelPrice(InputParameters, LEVEL_TWO)));
   
   ExecutionBoundary *CounterTakeProfitBoundary1 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)))  , GetNLevelPrice(InputParameters, LEVEL_ZERO));
   FullTradePool.AddRequest(CounterTakeProfitBoundary1, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));
   
   ExecutionBoundary *CounterTakeProfitBoundary2 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)))  , GetNLevelPrice(InputParameters, LEVEL_ONE));
   FullTradePool.AddRequest(CounterTakeProfitBoundary2, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))));
   
   ExecutionBoundary *CounterTakeProfitBoundary3 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE))), GetNLevelPrice(InputParameters, LEVEL_TWO));
   FullTradePool.AddRequest(CounterTakeProfitBoundary3, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE))));
   
   //--- Stop Loss Order
   ExecutionBoundary *OutOfBoundStopLossBoundary = new ExecutionBoundary(InputParameters.GetApexLevel(), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(0.03, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())), GetNLevelPrice(InputParameters, LEVEL_THREE));
   FullTradePool.AddRequest(StopLossBoundary, SellStopOrderRequest(0.06, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())));
   
   return FullTradePool;
}

namespace _AnonymousThreeLevelNetLongBigHedgeFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   ThreeLevelNetLongBigHedgeFactory AnonymousThreeLevelNetLongBigHedgeFactory;
}