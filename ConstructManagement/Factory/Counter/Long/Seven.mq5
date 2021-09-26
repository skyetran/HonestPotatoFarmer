#property strict

#include "../../../../ConstructManagement/Factory/Counter/Long/Seven.mqh"

namespace _AnonymousSevenLevelNetLongCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetLongCounterConstruct AnonymousSevenLevelNetLongCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetLongCounterFactory::SevenLevelNetLongCounterFactory(void) {
   Type = _AnonymousSevenLevelNetLongCounterConstructNameSpace::AnonymousSevenLevelNetLongCounterConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SevenLevelNetLongCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return new ConstructPreCheckInfo(GetMaxLotSizeExposure(InputParameters, SEVEN_LEVEL),
                                    GetPersistingLotSizeExposure(InputParameters, SEVEN_LEVEL),
                                    GetMaxPotentialLossInMinLotPointValue(InputParameters, SEVEN_LEVEL));
}

bool SevenLevelNetLongCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsSevenLevel(InputParameters)                                      &&
          IsNetLong(InputParameters)                                         &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *SevenLevelNetLongCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   SevenLevelNetLongCounterConstruct *NewConstruct = new SevenLevelNetLongCounterConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SevenLevelNetLongCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO) - PMHP.GetSlippageInPrice() - PMHP.GetSlippageInPrice()), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO) - PMHP.GetSlippageInPrice()));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyMarketOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, SEVEN_LEVEL)));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyMarketOrderRequest(GetCoveredCounterLotSizeNLevel(SIX_LEVEL  , InputParameters, SEVEN_LEVEL)));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyMarketOrderRequest(GetCoveredCounterLotSizeNLevel(FIVE_LEVEL , InputParameters, SEVEN_LEVEL)));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyMarketOrderRequest(GetCoveredCounterLotSizeNLevel(FOUR_LEVEL , InputParameters, SEVEN_LEVEL)));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyMarketOrderRequest(GetCoveredCounterLotSizeNLevel(THREE_LEVEL, InputParameters, SEVEN_LEVEL)));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyMarketOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, SEVEN_LEVEL)));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, SEVEN_LEVEL)));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, SEVEN_LEVEL)));
   
   //--- Retracement Entry Order
   ExecutionBoundary *RetracementEntryBoundary = new ExecutionBoundary(InputParameters.GetStopLossLevel(), InputParameters.GetApexLevel());
   FullTradePool.AddRequest(RetracementEntryBoundary, BuyStopLimitOrderRequest(GetCoveredCounterLotSizeNLevel(SIX_LEVEL  , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(RetracementEntryBoundary, BuyStopLimitOrderRequest(GetCoveredCounterLotSizeNLevel(FIVE_LEVEL , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(RetracementEntryBoundary, BuyStopLimitOrderRequest(GetCoveredCounterLotSizeNLevel(FOUR_LEVEL , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_THREE), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(RetracementEntryBoundary, BuyStopLimitOrderRequest(GetCoveredCounterLotSizeNLevel(THREE_LEVEL, InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(RetracementEntryBoundary, BuyStopLimitOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(RetracementEntryBoundary, BuyStopLimitOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_SIX)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(RetracementEntryBoundary, BuyStopLimitOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_SEVEN), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   
   //--- Counter Entry Order
   ExecutionBoundary *CounterEntryBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRequest(CounterEntryBoundary1, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)));
   
   ExecutionBoundary *CounterEntryBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRequest(CounterEntryBoundary2, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)));
   
   ExecutionBoundary *CounterEntryBoundary3 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRequest(CounterEntryBoundary3, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE)));
   
   ExecutionBoundary *CounterEntryBoundary4 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   FullTradePool.AddRequest(CounterEntryBoundary4, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   
   ExecutionBoundary *CounterEntryBoundary5 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   FullTradePool.AddRequest(CounterEntryBoundary5, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   
   ExecutionBoundary *CounterEntryBoundary6 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SIX)));
   FullTradePool.AddRequest(CounterEntryBoundary6, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SIX)));
   
   ExecutionBoundary *CounterEntryBoundary7 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_SIX)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SEVEN)));
   FullTradePool.AddRequest(CounterEntryBoundary7, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SEVEN)));
   
   //--- Take Profit Order
   ExecutionBoundary *RetracementTakeProfitBoundary0 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary0, SellLimitOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE)));
   
   ExecutionBoundary *RetracementTakeProfitBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary1, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(SIX_LEVEL  , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE)));
   
   ExecutionBoundary *RetracementTakeProfitBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary2, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(FIVE_LEVEL , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_TWO)));
   
   ExecutionBoundary *RetracementTakeProfitBoundary3 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary3, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(FOUR_LEVEL , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_THREE)));
   
   ExecutionBoundary *RetracementTakeProfitBoundary4 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary4, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(THREE_LEVEL, InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   
   ExecutionBoundary *RetracementTakeProfitBoundary5 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary5, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   
   ExecutionBoundary *RetracementTakeProfitBoundary6 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SIX)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary6, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_SIX)));
   
   ExecutionBoundary *RetracementTakeProfitBoundary7 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_SIX)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SEVEN)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary7, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_SEVEN)));
   
   ExecutionBoundary *CounterTakeProfitBoundary = new ExecutionBoundary(InputParameters.GetStopLossLevel(), InputParameters.GetApexLevel());
   FullTradePool.AddRequest(CounterTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(CounterTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));
   FullTradePool.AddRequest(CounterTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))));
   FullTradePool.AddRequest(CounterTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE))));
   FullTradePool.AddRequest(CounterTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR))));
   FullTradePool.AddRequest(CounterTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SIX)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE))));
   FullTradePool.AddRequest(CounterTakeProfitBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SEVEN), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SIX))));
   
   //--- Stop Loss Order
   ExecutionBoundary *OutOfBoundStopLossBoundary = new ExecutionBoundary(InputParameters.GetApexLevel(), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   FullTradePool.AddRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   FullTradePool.AddRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   FullTradePool.AddRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   FullTradePool.AddRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   FullTradePool.AddRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   FullTradePool.AddRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(InputParameters.GetStopLossLevel()), InputParameters.GetCapstoneLevel());
   FullTradePool.AddRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   FullTradePool.AddRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(SIX_LEVEL  , InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   FullTradePool.AddRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(FIVE_LEVEL , InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   FullTradePool.AddRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(FOUR_LEVEL , InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   FullTradePool.AddRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(THREE_LEVEL, InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   FullTradePool.AddRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   FullTradePool.AddRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   FullTradePool.AddRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   
   return FullTradePool;
}