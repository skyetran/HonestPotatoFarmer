#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Long/Three.mqh"

namespace _AnonymousThreeLevelNetLongFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   ThreeLevelNetLongFreeStylingConstruct AnonymousThreeLevelNetLongFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
ThreeLevelNetLongFreeStylingFactory::ThreeLevelNetLongFreeStylingFactory(void) {
   UniqueFactoryComment = "JQn4Itd3uVQpOdO9I7G8";
   Type = _AnonymousThreeLevelNetLongFreeStylingConstructNameSpace::AnonymousThreeLevelNetLongFreeStylingConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *ThreeLevelNetLongFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return new ConstructPreCheckInfo(GetMaxLotSizeExposure(InputParameters, THREE_LEVEL),
                                    GetPersistingLotSizeExposure(InputParameters, THREE_LEVEL),
                                    GetMaxPotentialLossInMinLotPointValue(InputParameters, THREE_LEVEL));
}

bool ThreeLevelNetLongFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsThreeLevel(InputParameters)                                      &&
          IsNetLong(InputParameters)                                         &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *ThreeLevelNetLongFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   ThreeLevelNetLongFreeStylingConstruct *NewConstruct = new ThreeLevelNetLongFreeStylingConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *ThreeLevelNetLongFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - InputParameters.GetIntervalSizeInPrice(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredAllCoveredRetracementLotSize(InputParameters, THREE_LEVEL), UniqueFactoryComment + FSL_UNIQUE_COMMENT_01));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredAllCoveredRetracementLotSize(InputParameters, THREE_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE), UniqueFactoryComment + FSL_UNIQUE_COMMENT_02));
   
   CompletionBoundary *BaseExitBoundary1 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ZERO, InputParameters), UniqueFactoryComment + FSL_UNIQUE_COMMENT_03), BaseExitBoundary1);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ZERO, InputParameters), GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + FSL_UNIQUE_COMMENT_04), BaseExitBoundary1);
 
   CompletionBoundary *BaseExitBoundary2 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ONE , InputParameters), UniqueFactoryComment + FSL_UNIQUE_COMMENT_05), BaseExitBoundary2);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ONE , InputParameters), GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + FSL_UNIQUE_COMMENT_06), BaseExitBoundary2);
   
   CompletionBoundary *BaseExitBoundary3 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_TWO , InputParameters), UniqueFactoryComment + FSL_UNIQUE_COMMENT_07), BaseExitBoundary3);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_TWO , InputParameters), GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + FSL_UNIQUE_COMMENT_08), BaseExitBoundary3);

   //--- Retracement Entry Order
   ExecutionBoundary  *RetracementEntryBoundary0 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   CompletionBoundary *RetracementExitBoundary0  = new CompletionBoundary(InputParameters.GetStopLossLevel(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO) - InputParameters.GetIntervalSizeInPrice()));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary0, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ZERO) - InputParameters.GetIntervalSizeInPrice(), UniqueFactoryComment + FSL_UNIQUE_COMMENT_09), RetracementExitBoundary0);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary0, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO) - InputParameters.GetIntervalSizeInPrice()), GetNLevelPrice(InputParameters, LEVEL_ZERO), UniqueFactoryComment + FSL_UNIQUE_COMMENT_10), RetracementExitBoundary0);

   ExecutionBoundary  *RetracementEntryBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   CompletionBoundary *RetracementExitBoundary1  = new CompletionBoundary(InputParameters.GetStopLossLevel(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary1, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ZERO), UniqueFactoryComment + FSL_UNIQUE_COMMENT_11), RetracementExitBoundary1);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary1, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)), GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + FSL_UNIQUE_COMMENT_12), RetracementExitBoundary1);
   
   ExecutionBoundary  *RetracementEntryBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   CompletionBoundary *RetracementExitBoundary2  = new CompletionBoundary(InputParameters.GetStopLossLevel(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary2, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE) , UniqueFactoryComment + FSL_UNIQUE_COMMENT_13), RetracementExitBoundary2);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary2, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)) , GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + FSL_UNIQUE_COMMENT_14), RetracementExitBoundary2);
   
   ExecutionBoundary  *RetracementEntryBoundary3 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   CompletionBoundary *RetracementExitBoundary3  = new CompletionBoundary(InputParameters.GetStopLossLevel(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary3, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO) , UniqueFactoryComment + FSL_UNIQUE_COMMENT_15), RetracementExitBoundary3);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary3, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)) , GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + FSL_UNIQUE_COMMENT_16), RetracementExitBoundary3);
   
   //--- Stop Loss Order
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())), GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredAllCoveredRetracementLotSize(InputParameters, THREE_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_17));
   
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ZERO, InputParameters), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_18));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ONE , InputParameters), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_19));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_TWO , InputParameters), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_20));
   
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary0, SellStopOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_20));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary1, SellStopOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_21));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary2, SellStopOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_22));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary3, SellStopOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_23));
      
   return FullTradePool;
}

namespace _AnonymousThreeLevelNetLongFreeStylingFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   ThreeLevelNetLongFreeStylingFactory AnonymousThreeLevelNetLongFreeStylingFactory;
}