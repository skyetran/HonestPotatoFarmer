#property strict

#include "../../../../ConstructManagement/Factory/Counter/Short/Two.mqh"

namespace _AnonymousTwoLevelNetShortCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetShortCounterConstruct AnonymousTwoLevelNetShortCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetShortCounterFactory::TwoLevelNetShortCounterFactory(void) {
   UniqueFactoryComment = "iOBhGuP5OZmxQY0SCscP";
   Type = _AnonymousTwoLevelNetShortCounterConstructNameSpace::AnonymousTwoLevelNetShortCounterConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *TwoLevelNetShortCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return new ConstructPreCheckInfo(GetMaxLotSizeExposure(InputParameters, TWO_LEVEL),
                                    GetPersistingLotSizeExposure(InputParameters, TWO_LEVEL),
                                    GetMaxPotentialLossInMinLotPointValue(InputParameters, TWO_LEVEL));
}

bool TwoLevelNetShortCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsTwoLevel(InputParameters)                                        &&
          IsNetShort(InputParameters)                                        &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *TwoLevelNetShortCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   TwoLevelNetShortCounterConstruct *NewConstruct = new TwoLevelNetShortCounterConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *TwoLevelNetShortCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) , GetNLevelPrice(InputParameters, LEVEL_ZERO) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, TWO_LEVEL), UniqueFactoryComment + CS_UNIQUE_COMMENT_01));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, TWO_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE), UniqueFactoryComment + CS_UNIQUE_COMMENT_02));
   
   CompletionBoundary *BaseExitBoundary1 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL , InputParameters, TWO_LEVEL), UniqueFactoryComment + CS_UNIQUE_COMMENT_03), BaseExitBoundary1);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL , InputParameters, TWO_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE), UniqueFactoryComment + CS_UNIQUE_COMMENT_04), BaseExitBoundary1);
   
   CompletionBoundary *BaseExitBoundary2 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));  
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL, InputParameters, TWO_LEVEL), UniqueFactoryComment + CS_UNIQUE_COMMENT_05), BaseExitBoundary2);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL, InputParameters, TWO_LEVEL), GetNLevelPrice(InputParameters, LEVEL_TWO), UniqueFactoryComment + CS_UNIQUE_COMMENT_06), BaseExitBoundary2);
   
   //--- Counter Entry Order
   ExecutionBoundary *CounterEntryBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO), GetNLevelPrice(InputParameters, LEVEL_ZERO) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary1, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE), UniqueFactoryComment + CS_UNIQUE_COMMENT_07), BaseExitBoundary1);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary1, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)), GetNLevelPrice(InputParameters, LEVEL_ZERO), UniqueFactoryComment + CS_UNIQUE_COMMENT_08), BaseExitBoundary1);
   
   ExecutionBoundary *CounterEntryBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE) , GetNLevelPrice(InputParameters, LEVEL_ZERO));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary2, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO), UniqueFactoryComment + CS_UNIQUE_COMMENT_09), BaseExitBoundary2);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary2, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)), GetNLevelPrice(InputParameters, LEVEL_ONE) , UniqueFactoryComment + CS_UNIQUE_COMMENT_10), BaseExitBoundary2);
   
   //--- Stop Loss Order
   ExecutionBoundary *OutOfBoundStopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)), GetStopLevelUpperOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, SellStopOrderRequest(0.02, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), UniqueFactoryComment + CS_UNIQUE_COMMENT_11));
   
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelLowerOffsetPriceEntry(InputParameters.GetStopLossLevel()) - InputParameters.GetIntervalSizeInPrice(), GetStopLevelLowerOffsetPriceEntry(InputParameters.GetStopLossLevel()));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, TWO_LEVEL)        , GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CS_UNIQUE_COMMENT_12));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL , InputParameters, TWO_LEVEL), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CS_UNIQUE_COMMENT_13));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL, InputParameters, TWO_LEVEL), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CS_UNIQUE_COMMENT_14));
   
   return FullTradePool;
}

namespace _AnonymousTwoLevelNetShortCounterFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   TwoLevelNetShortCounterFactory AnonymousTwoLevelNetShortCounterFactory;
}