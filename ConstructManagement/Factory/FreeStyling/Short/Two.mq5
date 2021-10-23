#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Short/Two.mqh"

namespace _AnonymousTwoLevelNetShortFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetShortFreeStylingConstruct AnonymousTwoLevelNetShortFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetShortFreeStylingFactory::TwoLevelNetShortFreeStylingFactory(void) {
   UniqueFactoryComment = "fGTzsBuGTUvzpKtlLaIa";
   Type = _AnonymousTwoLevelNetShortFreeStylingConstructNameSpace::AnonymousTwoLevelNetShortFreeStylingConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *TwoLevelNetShortFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return new ConstructPreCheckInfo(GetMaxLotSizeExposure(InputParameters, TWO_LEVEL),
                                    GetPersistingLotSizeExposure(InputParameters, TWO_LEVEL),
                                    GetMaxPotentialLossInMinLotPointValue(InputParameters, TWO_LEVEL));
}

bool TwoLevelNetShortFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsTwoLevel(InputParameters)                                        &&
          IsNetShort(InputParameters)                                        &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *TwoLevelNetShortFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   TwoLevelNetShortFreeStylingConstruct *NewConstruct = new TwoLevelNetShortFreeStylingConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *TwoLevelNetShortFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) + PMHP.GetSlippageInPrice(), GetNLevelPrice(InputParameters, LEVEL_ZERO) + InputParameters.GetIntervalSizeInPrice() + PMHP.GetSlippageInPrice());
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredAllCoveredRetracementLotSize(InputParameters, TWO_LEVEL), UniqueFactoryComment + FSS_UNIQUE_COMMENT_01));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredAllCoveredRetracementLotSize(InputParameters, TWO_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE), UniqueFactoryComment + FSS_UNIQUE_COMMENT_02));
   
   CompletionBoundary *BaseExitBoundary1 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ZERO, InputParameters), UniqueFactoryComment + FSS_UNIQUE_COMMENT_03), BaseExitBoundary1);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ZERO , InputParameters), GetNLevelPrice(InputParameters, LEVEL_ONE), UniqueFactoryComment + FSS_UNIQUE_COMMENT_04), BaseExitBoundary1);

   CompletionBoundary *BaseExitBoundary2 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ONE , InputParameters), UniqueFactoryComment + FSS_UNIQUE_COMMENT_05), BaseExitBoundary2);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ONE  , InputParameters), GetNLevelPrice(InputParameters, LEVEL_TWO), UniqueFactoryComment + FSS_UNIQUE_COMMENT_06), BaseExitBoundary2);

   //--- Retracement Entry Order
   ExecutionBoundary  *RetracementEntryBoundary0 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   CompletionBoundary *RetracementExitBoundary0  = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) + InputParameters.GetIntervalSizeInPrice(), InputParameters.GetStopLossLevel());
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary0, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ZERO) + InputParameters.GetIntervalSizeInPrice(), UniqueFactoryComment + FSS_UNIQUE_COMMENT_07), RetracementExitBoundary0);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary0, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) + InputParameters.GetIntervalSizeInPrice(), GetNLevelPrice(InputParameters, LEVEL_ZERO), UniqueFactoryComment + FSS_UNIQUE_COMMENT_08), RetracementExitBoundary0);   
   
   ExecutionBoundary  *RetracementEntryBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   CompletionBoundary *RetracementExitBoundary1  = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO), InputParameters.GetStopLossLevel());
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary1, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ZERO), UniqueFactoryComment + FSS_UNIQUE_COMMENT_09), RetracementExitBoundary1);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary1, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)), GetNLevelPrice(InputParameters, LEVEL_ONE), UniqueFactoryComment + FSS_UNIQUE_COMMENT_10), RetracementExitBoundary1);
   
   ExecutionBoundary  *RetracementEntryBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   CompletionBoundary *RetracementExitBoundary2  = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE) , InputParameters.GetStopLossLevel());
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary2, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE) , UniqueFactoryComment + FSS_UNIQUE_COMMENT_11), RetracementExitBoundary2);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary2, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)) , GetNLevelPrice(InputParameters, LEVEL_TWO), UniqueFactoryComment + FSS_UNIQUE_COMMENT_12), RetracementExitBoundary2);
   
   //--- Stop Loss Order
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelLowerOffsetPriceEntry(InputParameters.GetStopLossLevel()) - InputParameters.GetIntervalSizeInPrice(), GetStopLevelLowerOffsetPriceEntry(InputParameters.GetStopLossLevel()));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredAllCoveredRetracementLotSize(InputParameters, TWO_LEVEL), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_13));
   
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ZERO, InputParameters), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_14));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ONE , InputParameters), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_15));
   
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary0, BuyStopOrderRequest(0.01, GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_16));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary1, BuyStopOrderRequest(0.01, GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_17));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary2, BuyStopOrderRequest(0.01, GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_18));
   
   return FullTradePool;
}

namespace _AnonymousTwoLevelNetShortFreeStylingFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   TwoLevelNetShortFreeStylingFactory AnonymousTwoLevelNetShortFreeStylingFactory;
}