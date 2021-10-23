#property strict

#include "../../../../ConstructManagement/Factory/Counter/Long/Three.mqh"

namespace _AnonymousThreeLevelNetLongCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetLongCounterConstruct AnonymousThreeLevelNetLongCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetLongCounterFactory::ThreeLevelNetLongCounterFactory(void) {
   UniqueFactoryComment = "bBRp7MDQt2HIZGULeyJq";
   Type = _AnonymousThreeLevelNetLongCounterConstructNameSpace::AnonymousThreeLevelNetLongCounterConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *ThreeLevelNetLongCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return new ConstructPreCheckInfo(GetMaxLotSizeExposure(InputParameters, THREE_LEVEL),
                                    GetPersistingLotSizeExposure(InputParameters, THREE_LEVEL),
                                    GetMaxPotentialLossInMinLotPointValue(InputParameters, THREE_LEVEL));
}

bool ThreeLevelNetLongCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsThreeLevel(InputParameters)                                      &&
          IsNetLong(InputParameters)                                         &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *ThreeLevelNetLongCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   ThreeLevelNetLongCounterConstruct *NewConstruct = new ThreeLevelNetLongCounterConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *ThreeLevelNetLongCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - InputParameters.GetIntervalSizeInPrice() - PMHP.GetSlippageInPrice(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - PMHP.GetSlippageInPrice());
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, THREE_LEVEL), UniqueFactoryComment + CL_UNIQUE_COMMENT_01));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, THREE_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE), UniqueFactoryComment + CL_UNIQUE_COMMENT_02));
   
   CompletionBoundary *BaseExitBoundary1 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL , InputParameters, THREE_LEVEL), UniqueFactoryComment + CL_UNIQUE_COMMENT_03), BaseExitBoundary1);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(   TWO_LEVEL , InputParameters, THREE_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + CL_UNIQUE_COMMENT_04), BaseExitBoundary1);
   
   CompletionBoundary *BaseExitBoundary2 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL , InputParameters, THREE_LEVEL), UniqueFactoryComment + CL_UNIQUE_COMMENT_05), BaseExitBoundary2);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(   ONE_LEVEL , InputParameters, THREE_LEVEL), GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + CL_UNIQUE_COMMENT_06), BaseExitBoundary2);
   
   CompletionBoundary *BaseExitBoundary3 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL, InputParameters, THREE_LEVEL), UniqueFactoryComment + CL_UNIQUE_COMMENT_07), BaseExitBoundary3);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(   ZERO_LEVEL, InputParameters, THREE_LEVEL), GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + CL_UNIQUE_COMMENT_08), BaseExitBoundary3);
   
   //--- Counter Entry Order
   ExecutionBoundary *CounterEntryBoundary1 = new ExecutionBoundary(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - InputParameters.GetIntervalSizeInPrice(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary1, SellLimitOrderRequest(   MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + CL_UNIQUE_COMMENT_09), BaseExitBoundary1);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary1, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))  , GetNLevelPrice(InputParameters, LEVEL_ZERO), UniqueFactoryComment + CL_UNIQUE_COMMENT_10), BaseExitBoundary1);
   
   ExecutionBoundary *CounterEntryBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary2, SellLimitOrderRequest(   MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + CL_UNIQUE_COMMENT_11), BaseExitBoundary2);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary2, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))  , GetNLevelPrice(InputParameters, LEVEL_ONE) , UniqueFactoryComment + CL_UNIQUE_COMMENT_12), BaseExitBoundary2);

   ExecutionBoundary *CounterEntryBoundary3 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary3, SellLimitOrderRequest(   MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + CL_UNIQUE_COMMENT_13), BaseExitBoundary3);
   FullTradePool.AddRecurrentRequest(CounterEntryBoundary3, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)), GetNLevelPrice(InputParameters, LEVEL_TWO) , UniqueFactoryComment + CL_UNIQUE_COMMENT_14), BaseExitBoundary3);

   //--- Stop Loss Order
   ExecutionBoundary *OutOfBoundStopLossBoundary = new ExecutionBoundary(GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)) - InputParameters.GetIntervalSizeInPrice(), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(0.03, GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), UniqueFactoryComment + CL_UNIQUE_COMMENT_15));
   
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())), GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, THREE_LEVEL)         , GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CL_UNIQUE_COMMENT_16));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, THREE_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CL_UNIQUE_COMMENT_17));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, THREE_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CL_UNIQUE_COMMENT_18));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, THREE_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + CL_UNIQUE_COMMENT_19));
   
   return FullTradePool;
}

namespace _AnonymousThreeLevelNetLongCounterFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   ThreeLevelNetLongCounterFactory AnonymousThreeLevelNetLongCounterFactory;
}