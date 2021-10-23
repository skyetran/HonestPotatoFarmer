#property strict

#include "../../../../ConstructManagement/Factory/Counter/Long/Six.mqh"

namespace _AnonymousSixLevelNetLongCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetLongCounterConstruct AnonymousSixLevelNetLongCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetLongCounterFactory::SixLevelNetLongCounterFactory(void) {
   UniqueFactoryComment = "3LDJI1ZMZpKCkxMUOFhj";
   Type = _AnonymousSixLevelNetLongCounterConstructNameSpace::AnonymousSixLevelNetLongCounterConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SixLevelNetLongCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return new ConstructPreCheckInfo(GetMaxLotSizeExposure(InputParameters, SIX_LEVEL),
                                    GetPersistingLotSizeExposure(InputParameters, SIX_LEVEL),
                                    GetMaxPotentialLossInMinLotPointValue(InputParameters, SIX_LEVEL));
}

bool SixLevelNetLongCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsSixLevel(InputParameters)                                        &&
          IsNetLong(InputParameters)                                         &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *SixLevelNetLongCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   SixLevelNetLongCounterConstruct *NewConstruct = new SixLevelNetLongCounterConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SixLevelNetLongCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - InputParameters.GetIntervalSizeInPrice() - PMHP.GetSlippageInPrice(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - PMHP.GetSlippageInPrice());
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, SIX_LEVEL), UniqueFactoryComment + CL_UNIQUE_COMMENT_01));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, SIX_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE), UniqueFactoryComment + CL_UNIQUE_COMMENT_02));
   
   CompletionBoundary *BaseExitBoundary1 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(FIVE_LEVEL , InputParameters, SIX_LEVEL), UniqueFactoryComment + CL_UNIQUE_COMMENT_03), BaseExitBoundary1);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(   FIVE_LEVEL , InputParameters, SIX_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + CL_UNIQUE_COMMENT_04), BaseExitBoundary1);
   
   CompletionBoundary *BaseExitBoundary2 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(FOUR_LEVEL , InputParameters, SIX_LEVEL), UniqueFactoryComment + CL_UNIQUE_COMMENT_05), BaseExitBoundary2);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(   FOUR_LEVEL , InputParameters, SIX_LEVEL), GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + CL_UNIQUE_COMMENT_06), BaseExitBoundary2);
   
   CompletionBoundary *BaseExitBoundary3 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(THREE_LEVEL, InputParameters, SIX_LEVEL), UniqueFactoryComment + CL_UNIQUE_COMMENT_07), BaseExitBoundary3);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(   THREE_LEVEL, InputParameters, SIX_LEVEL), GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + CL_UNIQUE_COMMENT_08), BaseExitBoundary3);
   
   CompletionBoundary *BaseExitBoundary4 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, SIX_LEVEL), UniqueFactoryComment + CL_UNIQUE_COMMENT_09), BaseExitBoundary4);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(   TWO_LEVEL  , InputParameters, SIX_LEVEL), GetNLevelPrice(InputParameters, LEVEL_FOUR) , UniqueFactoryComment + CL_UNIQUE_COMMENT_10), BaseExitBoundary4);
   
   CompletionBoundary *BaseExitBoundary5 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, SIX_LEVEL), UniqueFactoryComment + CL_UNIQUE_COMMENT_11), BaseExitBoundary5);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(   ONE_LEVEL  , InputParameters, SIX_LEVEL), GetNLevelPrice(InputParameters, LEVEL_FIVE) , UniqueFactoryComment + CL_UNIQUE_COMMENT_12), BaseExitBoundary5);
   
   CompletionBoundary *BaseExitBoundary6 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_SIX)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, SIX_LEVEL), UniqueFactoryComment + CL_UNIQUE_COMMENT_13), BaseExitBoundary6);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(   ZERO_LEVEL , InputParameters, SIX_LEVEL), GetNLevelPrice(InputParameters, LEVEL_SIX)  , UniqueFactoryComment + CL_UNIQUE_COMMENT_14), BaseExitBoundary6);
   
   //--- Counter Entry Order
   ExecutionBoundary *CounterEntryBoundary1 = new ExecutionBoundary(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - InputParameters.GetIntervalSizeInPrice(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary1, SellLimitOrderRequest(   MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + CL_UNIQUE_COMMENT_15), BaseExitBoundary1);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary1, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))  , GetNLevelPrice(InputParameters, LEVEL_ZERO) , UniqueFactoryComment + CL_UNIQUE_COMMENT_16), BaseExitBoundary1);
   
   ExecutionBoundary *CounterEntryBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary2, SellLimitOrderRequest(   MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + CL_UNIQUE_COMMENT_17), BaseExitBoundary2);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary2, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))  , GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + CL_UNIQUE_COMMENT_18), BaseExitBoundary2);

   ExecutionBoundary *CounterEntryBoundary3 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary3, SellLimitOrderRequest(   MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + CL_UNIQUE_COMMENT_19), BaseExitBoundary3);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary3, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)), GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + CL_UNIQUE_COMMENT_20), BaseExitBoundary3);

   ExecutionBoundary *CounterEntryBoundary4 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary4, SellLimitOrderRequest(   MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FOUR) , UniqueFactoryComment + CL_UNIQUE_COMMENT_21), BaseExitBoundary4);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary4, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)) , GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + CL_UNIQUE_COMMENT_22), BaseExitBoundary4);
   
   ExecutionBoundary *CounterEntryBoundary5 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary5, SellLimitOrderRequest(   MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FIVE) , UniqueFactoryComment + CL_UNIQUE_COMMENT_23), BaseExitBoundary5);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary5, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)) , GetNLevelPrice(InputParameters, LEVEL_FOUR) , UniqueFactoryComment + CL_UNIQUE_COMMENT_24), BaseExitBoundary5);

   ExecutionBoundary *CounterEntryBoundary6 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary6, SellLimitOrderRequest(   MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_SIX)  , UniqueFactoryComment + CL_UNIQUE_COMMENT_25), BaseExitBoundary6);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary6, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SIX))  , GetNLevelPrice(InputParameters, LEVEL_FIVE) , UniqueFactoryComment + CL_UNIQUE_COMMENT_26), BaseExitBoundary6);
   
   //--- Stop Loss Order
   ExecutionBoundary *OutOfBoundStopLossBoundary = new ExecutionBoundary(GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)) - InputParameters.GetIntervalSizeInPrice(), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(0.06, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), UniqueFactoryComment + CL_UNIQUE_COMMENT_27));
   
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())), GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, SIX_LEVEL)         , GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CL_UNIQUE_COMMENT_28));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(FIVE_LEVEL , InputParameters, SIX_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CL_UNIQUE_COMMENT_29));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(FOUR_LEVEL , InputParameters, SIX_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CL_UNIQUE_COMMENT_30));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(THREE_LEVEL, InputParameters, SIX_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CL_UNIQUE_COMMENT_31));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, SIX_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CL_UNIQUE_COMMENT_32));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, SIX_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CL_UNIQUE_COMMENT_33));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, SIX_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CL_UNIQUE_COMMENT_34));
   
   return FullTradePool;
}

namespace _AnonymousSixLevelNetLongCounterFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   SixLevelNetLongCounterFactory AnonymousSixLevelNetLongCounterFactory;
}