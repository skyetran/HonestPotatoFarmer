#property strict

#include "../../../../ConstructManagement/Factory/Counter/Short/Seven.mqh"

namespace _AnonymousSevenLevelNetShortCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetShortCounterConstruct AnonymousSevenLevelNetShortCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetShortCounterFactory::SevenLevelNetShortCounterFactory(void) {
   Type = _AnonymousSevenLevelNetShortCounterConstructNameSpace::AnonymousSevenLevelNetShortCounterConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SevenLevelNetShortCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return new ConstructPreCheckInfo(GetMaxLotSizeExposure(InputParameters, SEVEN_LEVEL),
                                    GetPersistingLotSizeExposure(InputParameters, SEVEN_LEVEL),
                                    GetMaxPotentialLossInMinLotPointValue(InputParameters, SEVEN_LEVEL));
}

bool SevenLevelNetShortCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsSevenLevel(InputParameters)                                      &&
          IsNetShort(InputParameters)                                        &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *SevenLevelNetShortCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   SevenLevelNetShortCounterConstruct *NewConstruct = new SevenLevelNetShortCounterConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SevenLevelNetShortCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) + PMHP.GetSlippageInPrice(), GetNLevelPrice(InputParameters, LEVEL_ZERO) + PMHP.GetSlippageInPrice() + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, SEVEN_LEVEL)));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, SEVEN_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));
   
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(SIX_LEVEL  , InputParameters, SEVEN_LEVEL)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(FIVE_LEVEL , InputParameters, SEVEN_LEVEL)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(FOUR_LEVEL , InputParameters, SEVEN_LEVEL)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(THREE_LEVEL, InputParameters, SEVEN_LEVEL)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, SEVEN_LEVEL)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, SEVEN_LEVEL)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, SEVEN_LEVEL)));
   
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(SIX_LEVEL  , InputParameters, SEVEN_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(FIVE_LEVEL , InputParameters, SEVEN_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(FOUR_LEVEL , InputParameters, SEVEN_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE))));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(THREE_LEVEL, InputParameters, SEVEN_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR))));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, SEVEN_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE))));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, SEVEN_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SIX))));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, SEVEN_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SEVEN))));
   
   //--- Counter Entry Order
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))  , GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))  , GetNLevelPrice(InputParameters, LEVEL_ONE)));

   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE))));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)), GetNLevelPrice(InputParameters, LEVEL_TWO)));
   
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR))));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)) , GetNLevelPrice(InputParameters, LEVEL_THREE)));

   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE))));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)) , GetNLevelPrice(InputParameters, LEVEL_FOUR)));

   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SIX))));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SIX))  , GetNLevelPrice(InputParameters, LEVEL_FIVE)));

   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SEVEN))));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SEVEN)), GetNLevelPrice(InputParameters, LEVEL_SIX)));
            
   //--- Stop Loss Order
   ExecutionBoundary *OutOfBoundStopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)), GetStopLevelUpperOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, SellStopOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, SellStopOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, SellStopOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, SellStopOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, SellStopOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, SellStopOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, SellStopOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelLowerOffsetPriceEntry(InputParameters.GetStopLossLevel()) - InputParameters.GetIntervalSizeInPrice(), GetStopLevelLowerOffsetPriceEntry(InputParameters.GetStopLossLevel()));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(SIX_LEVEL  , InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(FIVE_LEVEL , InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(FOUR_LEVEL , InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(THREE_LEVEL, InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, SEVEN_LEVEL), InputParameters.GetStopLossLevel()));
   
   return FullTradePool;
}

namespace _AnonymousSevenLevelNetShortCounterFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   SevenLevelNetShortCounterFactory AnonymousSevenLevelNetShortCounterFactory;
}