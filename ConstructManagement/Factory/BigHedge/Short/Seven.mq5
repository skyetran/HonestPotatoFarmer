#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Short/Seven.mqh"

namespace _AnonymousSevenLevelNetShortBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetShortBigHedgeConstruct AnonymousSevenLevelNetShortBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetShortBigHedgeFactory::SevenLevelNetShortBigHedgeFactory(void) {
   Type = _AnonymousSevenLevelNetShortBigHedgeConstructNameSpace::AnonymousSevenLevelNetShortBigHedgeConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SevenLevelNetShortBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   int DeathZoneSize = PriceToPointCvt(MathAbs(GetNLevelPrice(InputParameters, LEVEL_SEVEN) - InputParameters.GetStopLossLevel()));
   int MaxPotentialLossInMinLotPointValue = 14 * IP.GetAverageSpreadInPts(CURRENT_BAR) + 42 * InputParameters.GetIntervalSizeInPts() + 14 * DeathZoneSize;
   return new ConstructPreCheckInfo(0.14, 0.14, MaxPotentialLossInMinLotPointValue);;
}

bool SevenLevelNetShortBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsSevenLevel(InputParameters)                                      &&
          IsNetShort(InputParameters)                                        &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *SevenLevelNetShortBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   SevenLevelNetShortBigHedgeConstruct *NewConstruct = new SevenLevelNetShortBigHedgeConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SevenLevelNetShortBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - PMHP.GetSlippageInPrice(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, SellRawMarketOrderRequest(0.07));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(MIN_LOT_SIZE));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(MIN_LOT_SIZE));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(MIN_LOT_SIZE));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(MIN_LOT_SIZE));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(MIN_LOT_SIZE));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(MIN_LOT_SIZE));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(MIN_LOT_SIZE));
   
   //--- Retracement Entry Order
   ExecutionBoundary *RetracementEntryBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary1, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)));

   ExecutionBoundary *RetracementEntryBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary2, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)));
   
   ExecutionBoundary *RetracementEntryBoundary3 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary3, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE)));
   
   ExecutionBoundary *RetracementEntryBoundary4 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary4, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   
   ExecutionBoundary *RetracementEntryBoundary5 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary5, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   
   ExecutionBoundary *RetracementEntryBoundary6 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SIX)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary6, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SIX)));
   
   ExecutionBoundary *RetracementEntryBoundary7 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_SIX)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SEVEN)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary7, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SEVEN)));
   
   //--- Counter Entry Order
   ExecutionBoundary *CounterEntryBoundary = new ExecutionBoundary(InputParameters.GetApexLevel(), InputParameters.GetStopLossLevel());
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SIX)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SEVEN), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   
   //--- Take Profit Order
   ExecutionBoundary *OutOfBoundTakeProfitBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)), GetStopLevelUpperOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(OutOfBoundTakeProfitBoundary, BuyLimitOrderRequest(0.07, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   
   ExecutionBoundary *RetracementTakeProfitBoundary = new ExecutionBoundary(InputParameters.GetApexLevel(), InputParameters.GetStopLossLevel());
   FullTradePool.AddRecurrentRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRecurrentRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));
   FullTradePool.AddRecurrentRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))));
   FullTradePool.AddRecurrentRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE))));
   FullTradePool.AddRecurrentRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR))));
   FullTradePool.AddRecurrentRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SIX)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE))));
   FullTradePool.AddRecurrentRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SEVEN), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SIX))));
   
   ExecutionBoundary *CounterTakeProfitBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRecurrentRequest(CounterTakeProfitBoundary1, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)));
   
   ExecutionBoundary *CounterTakeProfitBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRecurrentRequest(CounterTakeProfitBoundary2, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)));
   
   ExecutionBoundary *CounterTakeProfitBoundary3 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRecurrentRequest(CounterTakeProfitBoundary3, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE)));
   
   ExecutionBoundary *CounterTakeProfitBoundary4 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   FullTradePool.AddRecurrentRequest(CounterTakeProfitBoundary4, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   
   ExecutionBoundary *CounterTakeProfitBoundary5 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   FullTradePool.AddRecurrentRequest(CounterTakeProfitBoundary5, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   
   ExecutionBoundary *CounterTakeProfitBoundary6 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SIX)));
   FullTradePool.AddRecurrentRequest(CounterTakeProfitBoundary6, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SIX)));
   
   ExecutionBoundary *CounterTakeProfitBoundary7 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_SIX)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SEVEN)));
   FullTradePool.AddRecurrentRequest(CounterTakeProfitBoundary7, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SEVEN)));
   
   //--- Stop Loss Order
   ExecutionBoundary *OutOfBoundStopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)), GetStopLevelUpperOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, SellStopOrderRequest(0.07, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_SEVEN), GetStopLevelLowerOffsetPriceEntry(InputParameters.GetStopLossLevel()));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(0.14, InputParameters.GetStopLossLevel()));
   
   return FullTradePool;
}

namespace _AnonymousSevenLevelNetShortBigHedgeFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   SevenLevelNetShortBigHedgeFactory AnonymousSevenLevelNetShortBigHedgeFactory;
}