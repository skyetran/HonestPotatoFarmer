#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Short/Two.mqh"

namespace _AnonymousTwoLevelNetShortBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetShortBigHedgeConstruct AnonymousTwoLevelNetShortBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetShortBigHedgeFactory::TwoLevelNetShortBigHedgeFactory(void) {
   Type = _AnonymousTwoLevelNetShortBigHedgeConstructNameSpace::AnonymousTwoLevelNetShortBigHedgeConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *TwoLevelNetShortBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   int DeathZoneSize = PriceToPointCvt(MathAbs(GetNLevelPrice(InputParameters, LEVEL_TWO) - InputParameters.GetStopLossLevel()));
   int MaxPotentialLossInMinLotPointValue = 4 * IP.GetAverageSpreadInPts(CURRENT_BAR) + 2 * InputParameters.GetIntervalSizeInPts() + 4 * DeathZoneSize;
   return new ConstructPreCheckInfo(0.04, 0.04, MaxPotentialLossInMinLotPointValue);
}

bool TwoLevelNetShortBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsTwoLevel(InputParameters)                                        &&
          IsNetShort(InputParameters)                                        &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *TwoLevelNetShortBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   TwoLevelNetShortBigHedgeConstruct *NewConstruct = new TwoLevelNetShortBigHedgeConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *TwoLevelNetShortBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - PMHP.GetSlippageInPrice(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRequest(BaseEntryBoundary, SellRawMarketOrderRequest(0.02));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(MIN_LOT_SIZE));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(MIN_LOT_SIZE));
   
   //--- Retracement Entry Order
   ExecutionBoundary *RetracementEntryBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRequest(RetracementEntryBoundary1, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)));

   ExecutionBoundary *RetracementEntryBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRequest(RetracementEntryBoundary2, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)));
   
   //--- Counter Entry Order
   ExecutionBoundary *CounterEntryBoundary = new ExecutionBoundary(InputParameters.GetApexLevel(), InputParameters.GetStopLossLevel());
   FullTradePool.AddRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   
   //--- Take Profit Order
   ExecutionBoundary *OutOfBoundTakeProfitBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)), InputParameters.GetApexLevel());
   FullTradePool.AddRequest(OutOfBoundTakeProfitBoundary, BuyLimitOrderRequest(0.02, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   
   ExecutionBoundary *RetracementTakeProfitBoundary = new ExecutionBoundary(InputParameters.GetApexLevel(), InputParameters.GetStopLossLevel());
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));
   
   ExecutionBoundary *CounterTakeProfitBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRequest(CounterTakeProfitBoundary1, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)));
   
   ExecutionBoundary *CounterTakeProfitBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRequest(CounterTakeProfitBoundary2, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)));
   
   //--- Stop Loss Order
   ExecutionBoundary *OutOfBoundStopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)), InputParameters.GetApexLevel());
   FullTradePool.AddRequest(OutOfBoundStopLossBoundary, SellStopOrderRequest(0.02, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO), GetStopLevelLowerOffsetPriceEntry(InputParameters.GetStopLossLevel()));
   FullTradePool.AddRequest(StopLossBoundary, BuyStopOrderRequest(0.04, InputParameters.GetStopLossLevel()));
   
   return FullTradePool;
}

namespace _AnonymousTwoLevelNetShortBigHedgeFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   TwoLevelNetShortBigHedgeFactory AnonymousTwoLevelNetShortBigHedgeFactory;
}