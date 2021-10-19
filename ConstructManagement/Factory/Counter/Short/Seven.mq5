#property strict

#include "../../../../ConstructManagement/Factory/Counter/Short/Seven.mqh"

namespace _AnonymousSevenLevelNetShortCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SevenLevelNetShortCounterConstruct AnonymousSevenLevelNetShortCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
SevenLevelNetShortCounterFactory::SevenLevelNetShortCounterFactory(void) {
   UniqueFactoryComment = "tSCREi6tgwKYzmVtkul9";
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
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO), GetNLevelPrice(InputParameters, LEVEL_ZERO) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, SEVEN_LEVEL), UniqueFactoryComment + CS_UNIQUE_COMMENT_01));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE), UniqueFactoryComment + CS_UNIQUE_COMMENT_02));
   
   CompletionBoundary *BaseExitBoundary1 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(SIX_LEVEL  , InputParameters, SEVEN_LEVEL), UniqueFactoryComment + CS_UNIQUE_COMMENT_03), BaseExitBoundary1);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(     SIX_LEVEL  , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + CS_UNIQUE_COMMENT_04), BaseExitBoundary1);
   
   CompletionBoundary *BaseExitBoundary2 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(FIVE_LEVEL , InputParameters, SEVEN_LEVEL), UniqueFactoryComment + CS_UNIQUE_COMMENT_05), BaseExitBoundary2);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(     FIVE_LEVEL , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + CS_UNIQUE_COMMENT_06), BaseExitBoundary2);
   
   CompletionBoundary *BaseExitBoundary3 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(FOUR_LEVEL , InputParameters, SEVEN_LEVEL), UniqueFactoryComment + CS_UNIQUE_COMMENT_07), BaseExitBoundary3);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(     FOUR_LEVEL , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + CS_UNIQUE_COMMENT_08), BaseExitBoundary3);
   
   CompletionBoundary *BaseExitBoundary4 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(THREE_LEVEL, InputParameters, SEVEN_LEVEL), UniqueFactoryComment + CS_UNIQUE_COMMENT_09), BaseExitBoundary4);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(     THREE_LEVEL, InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_FOUR) , UniqueFactoryComment + CS_UNIQUE_COMMENT_10), BaseExitBoundary4);
   
   CompletionBoundary *BaseExitBoundary5 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, SEVEN_LEVEL), UniqueFactoryComment + CS_UNIQUE_COMMENT_11), BaseExitBoundary5);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(     TWO_LEVEL  , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_FIVE) , UniqueFactoryComment + CS_UNIQUE_COMMENT_12), BaseExitBoundary5);
   
   CompletionBoundary *BaseExitBoundary6 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SIX)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, SEVEN_LEVEL), UniqueFactoryComment + CS_UNIQUE_COMMENT_13), BaseExitBoundary6);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(     ONE_LEVEL  , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_SIX)  , UniqueFactoryComment + CS_UNIQUE_COMMENT_14), BaseExitBoundary6);
   
   CompletionBoundary *BaseExitBoundary7 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SEVEN)));  
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, SEVEN_LEVEL), UniqueFactoryComment + CS_UNIQUE_COMMENT_15), BaseExitBoundary7);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(     ZERO_LEVEL , InputParameters, SEVEN_LEVEL), GetNLevelPrice(InputParameters, LEVEL_SEVEN), UniqueFactoryComment + CS_UNIQUE_COMMENT_16), BaseExitBoundary7);
   
   //--- Counter Entry Order
   ExecutionBoundary *CounterEntryBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) , GetNLevelPrice(InputParameters, LEVEL_ZERO) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary1, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + CS_UNIQUE_COMMENT_17), BaseExitBoundary1);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary1, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))  , GetNLevelPrice(InputParameters, LEVEL_ZERO) , UniqueFactoryComment + CS_UNIQUE_COMMENT_18), BaseExitBoundary1);
   
   ExecutionBoundary *CounterEntryBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetNLevelPrice(InputParameters, LEVEL_ZERO));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary2, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + CS_UNIQUE_COMMENT_19), BaseExitBoundary2);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary2, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))  , GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + CS_UNIQUE_COMMENT_20), BaseExitBoundary2);
   
   ExecutionBoundary *CounterEntryBoundary3 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetNLevelPrice(InputParameters, LEVEL_ONE));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary3, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + CS_UNIQUE_COMMENT_21), BaseExitBoundary3);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary3, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)), GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + CS_UNIQUE_COMMENT_22), BaseExitBoundary3);
   
   ExecutionBoundary *CounterEntryBoundary4 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetNLevelPrice(InputParameters, LEVEL_TWO));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary4, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FOUR) , UniqueFactoryComment + CS_UNIQUE_COMMENT_23), BaseExitBoundary4);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary4, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)) , GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + CS_UNIQUE_COMMENT_24), BaseExitBoundary4);

   ExecutionBoundary *CounterEntryBoundary5 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetNLevelPrice(InputParameters, LEVEL_THREE));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary5, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FIVE) , UniqueFactoryComment + CS_UNIQUE_COMMENT_25), BaseExitBoundary5);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary5, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)) , GetNLevelPrice(InputParameters, LEVEL_FOUR) , UniqueFactoryComment + CS_UNIQUE_COMMENT_26), BaseExitBoundary5);

   ExecutionBoundary *CounterEntryBoundary6 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetNLevelPrice(InputParameters, LEVEL_FOUR));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary6, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SIX)  , UniqueFactoryComment + CS_UNIQUE_COMMENT_27), BaseExitBoundary6);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary6, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SIX))  , GetNLevelPrice(InputParameters, LEVEL_FIVE) , UniqueFactoryComment + CS_UNIQUE_COMMENT_28), BaseExitBoundary6);

   ExecutionBoundary *CounterEntryBoundary7 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_SIX)  , GetNLevelPrice(InputParameters, LEVEL_FIVE));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary7, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SEVEN), UniqueFactoryComment + CS_UNIQUE_COMMENT_29), BaseExitBoundary7);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary7, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SEVEN)), GetNLevelPrice(InputParameters, LEVEL_SIX)  , UniqueFactoryComment + CS_UNIQUE_COMMENT_30), BaseExitBoundary7);
            
   //--- Stop Loss Order
   ExecutionBoundary *OutOfBoundStopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)), GetStopLevelUpperOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, SellStopOrderRequest(0.07, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), UniqueFactoryComment + CS_UNIQUE_COMMENT_31));
   
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelLowerOffsetPriceEntry(InputParameters.GetStopLossLevel()) - InputParameters.GetIntervalSizeInPrice(), GetStopLevelLowerOffsetPriceEntry(InputParameters.GetStopLossLevel()));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, SEVEN_LEVEL)         , GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CS_UNIQUE_COMMENT_32));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(SIX_LEVEL  , InputParameters, SEVEN_LEVEL), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CS_UNIQUE_COMMENT_33));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(FIVE_LEVEL , InputParameters, SEVEN_LEVEL), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CS_UNIQUE_COMMENT_34));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(FOUR_LEVEL , InputParameters, SEVEN_LEVEL), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CS_UNIQUE_COMMENT_35));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(THREE_LEVEL, InputParameters, SEVEN_LEVEL), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CS_UNIQUE_COMMENT_36));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, SEVEN_LEVEL), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CS_UNIQUE_COMMENT_37));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, SEVEN_LEVEL), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CS_UNIQUE_COMMENT_38));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, SEVEN_LEVEL), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CS_UNIQUE_COMMENT_39));
   
   return FullTradePool;
}

namespace _AnonymousSevenLevelNetShortCounterFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   SevenLevelNetShortCounterFactory AnonymousSevenLevelNetShortCounterFactory;
}