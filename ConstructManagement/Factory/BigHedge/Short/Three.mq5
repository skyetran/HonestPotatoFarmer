#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Short/Three.mqh"

namespace _AnonymousThreeLevelNetShortBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetShortBigHedgeConstruct AnonymousThreeLevelNetShortBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetShortBigHedgeFactory::ThreeLevelNetShortBigHedgeFactory(void) {
   Type = _AnonymousThreeLevelNetShortBigHedgeConstructNameSpace::AnonymousThreeLevelNetShortBigHedgeConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *ThreeLevelNetShortBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   int DeathZoneSize = PriceToPointCvt(MathAbs(GetNLevelPrice(InputParameters, LEVEL_THREE) - InputParameters.GetStopLossLevel()));
   int MaxPotentialLossInMinLotPointValue = 6 * IP.GetAverageSpreadInPts(CURRENT_BAR) + 6 * InputParameters.GetIntervalSizeInPts() + 6 * DeathZoneSize;
   return new ConstructPreCheckInfo(0.06, 0.06, MaxPotentialLossInMinLotPointValue);
}

bool ThreeLevelNetShortBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsThreeLevel(InputParameters)                                      &&
          IsNetShort(InputParameters)                                        &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *ThreeLevelNetShortBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   ThreeLevelNetShortBigHedgeConstruct *NewConstruct = new ThreeLevelNetShortBigHedgeConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *ThreeLevelNetShortBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - PMHP.GetSlippageInPrice(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRequest(BaseEntryBoundary, SellRawMarketOrderRequest(0.03));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(MIN_LOT_SIZE));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(MIN_LOT_SIZE));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(MIN_LOT_SIZE));
   
   //--- Retracement Entry Order
   ExecutionBoundary *RetracementEntryBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRequest(RetracementEntryBoundary1, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)));

   ExecutionBoundary *RetracementEntryBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRequest(RetracementEntryBoundary2, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)));
   
   ExecutionBoundary *RetracementEntryBoundary3 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRequest(RetracementEntryBoundary3, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE)));
   
   //--- Counter Entry Order
   ExecutionBoundary *CounterEntryBoundary = new ExecutionBoundary(InputParameters.GetApexLevel(), InputParameters.GetStopLossLevel());
   FullTradePool.AddRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   
   //--- Take Profit Order
   ExecutionBoundary *OutOfBoundTakeProfitBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)), InputParameters.GetApexLevel());
   FullTradePool.AddRequest(OutOfBoundTakeProfitBoundary, BuyLimitOrderRequest(0.03, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   
   ExecutionBoundary *RetracementTakeProfitBoundary = new ExecutionBoundary(InputParameters.GetApexLevel(), InputParameters.GetStopLossLevel());
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))));
   
   ExecutionBoundary *CounterTakeProfitBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRequest(CounterTakeProfitBoundary1, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)));
   
   ExecutionBoundary *CounterTakeProfitBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRequest(CounterTakeProfitBoundary2, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)));
   
   ExecutionBoundary *CounterTakeProfitBoundary3 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRequest(CounterTakeProfitBoundary3, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE)));
   
   //--- Stop Loss Order
   ExecutionBoundary *OutOfBoundStopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)), InputParameters.GetApexLevel());
   FullTradePool.AddRequest(OutOfBoundStopLossBoundary, SellStopOrderRequest(0.03, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetStopLevelLowerOffsetPriceEntry(InputParameters.GetStopLossLevel()));
   FullTradePool.AddRequest(StopLossBoundary, BuyStopOrderRequest(0.06, InputParameters.GetStopLossLevel()));
   
   return FullTradePool;
}

namespace _AnonymousThreeLevelNetShortBigHedgeFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   ThreeLevelNetShortBigHedgeFactory AnonymousThreeLevelNetShortBigHedgeFactory;
}