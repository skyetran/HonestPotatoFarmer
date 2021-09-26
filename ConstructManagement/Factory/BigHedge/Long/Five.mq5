#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Long/Five.mqh"

namespace _AnonymousFiveLevelNetLongBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetLongBigHedgeConstruct AnonymousFiveLevelNetLongBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetLongBigHedgeFactory::FiveLevelNetLongBigHedgeFactory(void) {
   Type = _AnonymousFiveLevelNetLongBigHedgeConstructNameSpace::AnonymousFiveLevelNetLongBigHedgeConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *FiveLevelNetLongBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   int DeathZoneSize = PriceToPointCvt(MathAbs(GetNLevelPrice(InputParameters, LEVEL_FIVE) - InputParameters.GetStopLossLevel()));
   int MaxPotentialLossInMinLotPointValue = 10 * IP.GetAverageSpreadInPts(CURRENT_BAR) + 20 * InputParameters.GetIntervalSizeInPts() + 10 * DeathZoneSize;
   return new ConstructPreCheckInfo(0.1, 0.1, MaxPotentialLossInMinLotPointValue);
}

bool FiveLevelNetLongBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsFiveLevel(InputParameters)                                       &&
          IsNetLong(InputParameters)                                         &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *FiveLevelNetLongBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   FiveLevelNetLongBigHedgeConstruct *NewConstruct = new FiveLevelNetLongBigHedgeConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *FiveLevelNetLongBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO), GetNLevelPrice(InputParameters, LEVEL_ZERO) + PMHP.GetSlippageInPrice());
   FullTradePool.AddRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(0.05));
   FullTradePool.AddRequest(BaseEntryBoundary, SellRawMarketOrderRequest(MIN_LOT_SIZE));
   FullTradePool.AddRequest(BaseEntryBoundary, SellRawMarketOrderRequest(MIN_LOT_SIZE));
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
   
   ExecutionBoundary *RetracementEntryBoundary4 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR))) , GetNLevelPrice(InputParameters, LEVEL_THREE));
   FullTradePool.AddRequest(RetracementEntryBoundary4, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR))));
   
   ExecutionBoundary *RetracementEntryBoundary5 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE))) , GetNLevelPrice(InputParameters, LEVEL_FOUR));
   FullTradePool.AddRequest(RetracementEntryBoundary5, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE))));
   
   //--- Counter Entry Order
   ExecutionBoundary *CounterEntryBoundary = new ExecutionBoundary(InputParameters.GetStopLossLevel(), InputParameters.GetApexLevel());
   FullTradePool.AddRequest(CounterEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))  , GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRequest(CounterEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))  , GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRequest(CounterEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)), GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRequest(CounterEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)) , GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRequest(CounterEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)) , GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   
   //--- Take Profit Order
   ExecutionBoundary *OutOfBoundTakeProfitBoundary = new ExecutionBoundary(InputParameters.GetApexLevel(), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddRequest(OutOfBoundTakeProfitBoundary, SellLimitOrderRequest(0.05, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   
   ExecutionBoundary *RetracementTakeProfitBoundary = new ExecutionBoundary(InputParameters.GetStopLossLevel(), InputParameters.GetApexLevel());
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))  , GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))  , GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)), GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)) , GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)) , GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   
   ExecutionBoundary *CounterTakeProfitBoundary1 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)))  , GetNLevelPrice(InputParameters, LEVEL_ZERO));
   FullTradePool.AddRequest(CounterTakeProfitBoundary1, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));
   
   ExecutionBoundary *CounterTakeProfitBoundary2 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)))  , GetNLevelPrice(InputParameters, LEVEL_ONE));
   FullTradePool.AddRequest(CounterTakeProfitBoundary1, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))));
   
   ExecutionBoundary *CounterTakeProfitBoundary3 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE))), GetNLevelPrice(InputParameters, LEVEL_TWO));
   FullTradePool.AddRequest(CounterTakeProfitBoundary1, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE))));
   
   ExecutionBoundary *CounterTakeProfitBoundary4 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR))) , GetNLevelPrice(InputParameters, LEVEL_THREE));
   FullTradePool.AddRequest(CounterTakeProfitBoundary1, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR))));
   
   ExecutionBoundary *CounterTakeProfitBoundary5 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE))) , GetNLevelPrice(InputParameters, LEVEL_FOUR));
   FullTradePool.AddRequest(CounterTakeProfitBoundary1, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE))));
   
   //--- Stop Loss Order
   ExecutionBoundary *OutOfBoundStopLossBoundary = new ExecutionBoundary(InputParameters.GetApexLevel(), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(0.05, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())), GetNLevelPrice(InputParameters, LEVEL_FIVE));
   FullTradePool.AddRequest(StopLossBoundary, SellStopOrderRequest(0.1, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())));
   
   return FullTradePool;
}

namespace _AnonymousFiveLevelNetLongBigHedgeFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   FiveLevelNetLongBigHedgeFactory AnonymousFiveLevelNetLongBigHedgeFactory;
}