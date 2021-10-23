#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Short/Five.mqh"

namespace _AnonymousFiveLevelNetShortFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetShortFreeStylingConstruct AnonymousFiveLevelNetShortFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetShortFreeStylingFactory::FiveLevelNetShortFreeStylingFactory(void) {
   UniqueFactoryComment = "IOXjNtrbM7Alc2bVBpuW";
   Type = _AnonymousFiveLevelNetShortFreeStylingConstructNameSpace::AnonymousFiveLevelNetShortFreeStylingConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *FiveLevelNetShortFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return new ConstructPreCheckInfo(GetMaxLotSizeExposure(InputParameters, FIVE_LEVEL),
                                    GetPersistingLotSizeExposure(InputParameters, FIVE_LEVEL),
                                    GetMaxPotentialLossInMinLotPointValue(InputParameters, FIVE_LEVEL));
}

bool FiveLevelNetShortFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsFiveLevel(InputParameters)                                       &&
          IsNetShort(InputParameters)                                        &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *FiveLevelNetShortFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   FiveLevelNetShortFreeStylingConstruct *NewConstruct = new FiveLevelNetShortFreeStylingConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *FiveLevelNetShortFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) + PMHP.GetSlippageInPrice(), GetNLevelPrice(InputParameters, LEVEL_ZERO) + InputParameters.GetIntervalSizeInPrice() + PMHP.GetSlippageInPrice());
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredAllCoveredRetracementLotSize(InputParameters, FIVE_LEVEL), UniqueFactoryComment + FSS_UNIQUE_COMMENT_01));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredAllCoveredRetracementLotSize(InputParameters, FIVE_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE), UniqueFactoryComment + FSS_UNIQUE_COMMENT_02));
   
   CompletionBoundary *BaseExitBoundary1 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ZERO , InputParameters), UniqueFactoryComment + FSS_UNIQUE_COMMENT_03), BaseExitBoundary1);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ZERO , InputParameters), GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + FSS_UNIQUE_COMMENT_04), BaseExitBoundary1);

   CompletionBoundary *BaseExitBoundary2 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ONE  , InputParameters), UniqueFactoryComment + FSS_UNIQUE_COMMENT_05), BaseExitBoundary2);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ONE  , InputParameters), GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + FSS_UNIQUE_COMMENT_06), BaseExitBoundary2);

   CompletionBoundary *BaseExitBoundary3 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_TWO  , InputParameters), UniqueFactoryComment + FSS_UNIQUE_COMMENT_07), BaseExitBoundary3);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_TWO  , InputParameters), GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + FSS_UNIQUE_COMMENT_08), BaseExitBoundary3);

   CompletionBoundary *BaseExitBoundary4 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_THREE, InputParameters), UniqueFactoryComment + FSS_UNIQUE_COMMENT_09), BaseExitBoundary4);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_THREE, InputParameters), GetNLevelPrice(InputParameters, LEVEL_FOUR) , UniqueFactoryComment + FSS_UNIQUE_COMMENT_10), BaseExitBoundary4);

   CompletionBoundary *BaseExitBoundary5 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_FOUR , InputParameters), UniqueFactoryComment + FSS_UNIQUE_COMMENT_11), BaseExitBoundary5);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_FOUR , InputParameters), GetNLevelPrice(InputParameters, LEVEL_FIVE) , UniqueFactoryComment + FSS_UNIQUE_COMMENT_12), BaseExitBoundary5);

   //--- Retracement Entry Order
   ExecutionBoundary  *RetracementEntryBoundary0 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   CompletionBoundary *RetracementExitBoundary0  = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) + InputParameters.GetIntervalSizeInPrice(), InputParameters.GetStopLossLevel());
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary0, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ZERO) + InputParameters.GetIntervalSizeInPrice(), UniqueFactoryComment + FSS_UNIQUE_COMMENT_13), RetracementExitBoundary0);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary0, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) + InputParameters.GetIntervalSizeInPrice(), GetNLevelPrice(InputParameters, LEVEL_ZERO), UniqueFactoryComment + FSS_UNIQUE_COMMENT_14), RetracementExitBoundary0);   
   
   ExecutionBoundary  *RetracementEntryBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   CompletionBoundary *RetracementExitBoundary1  = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) , InputParameters.GetStopLossLevel());
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary1, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ZERO) , UniqueFactoryComment + FSS_UNIQUE_COMMENT_15), RetracementExitBoundary1);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary1, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) , GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + FSS_UNIQUE_COMMENT_16), RetracementExitBoundary1);
   
   ExecutionBoundary  *RetracementEntryBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   CompletionBoundary *RetracementExitBoundary2  = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , InputParameters.GetStopLossLevel());
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary2, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + FSS_UNIQUE_COMMENT_17), RetracementExitBoundary2);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary2, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))  , GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + FSS_UNIQUE_COMMENT_18), RetracementExitBoundary2);
   
   ExecutionBoundary  *RetracementEntryBoundary3 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)));
   CompletionBoundary *RetracementExitBoundary3  = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , InputParameters.GetStopLossLevel());
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary3, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + FSS_UNIQUE_COMMENT_19), RetracementExitBoundary3);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary3, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))  , GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + FSS_UNIQUE_COMMENT_20), RetracementExitBoundary3);
   
   ExecutionBoundary  *RetracementEntryBoundary4 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   CompletionBoundary *RetracementExitBoundary4  = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), InputParameters.GetStopLossLevel());
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary4, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + FSS_UNIQUE_COMMENT_21), RetracementExitBoundary4);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary4, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)), GetNLevelPrice(InputParameters, LEVEL_FOUR) , UniqueFactoryComment + FSS_UNIQUE_COMMENT_22), RetracementExitBoundary4);
   
   ExecutionBoundary  *RetracementEntryBoundary5 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   CompletionBoundary *RetracementExitBoundary5  = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_FOUR) , InputParameters.GetStopLossLevel());
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary5, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FOUR) , UniqueFactoryComment + FSS_UNIQUE_COMMENT_23), RetracementExitBoundary5);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary5, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadRevOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)) , GetNLevelPrice(InputParameters, LEVEL_FIVE) , UniqueFactoryComment + FSS_UNIQUE_COMMENT_24), RetracementExitBoundary5);

   //--- Stop Loss Order
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelLowerOffsetPriceEntry(InputParameters.GetStopLossLevel()) - InputParameters.GetIntervalSizeInPrice(), GetStopLevelLowerOffsetPriceEntry(InputParameters.GetStopLossLevel()));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredAllCoveredRetracementLotSize(InputParameters, FIVE_LEVEL), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_25));
   
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ZERO , InputParameters), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_26));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ONE  , InputParameters), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_27));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_TWO  , InputParameters), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_28));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_THREE, InputParameters), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_29));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, BuyStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_FOUR , InputParameters), GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_30));
   
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary0, BuyStopOrderRequest(0.01, GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_31));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary1, BuyStopOrderRequest(0.01, GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_32));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary2, BuyStopOrderRequest(0.01, GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_33));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary3, BuyStopOrderRequest(0.01, GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_34));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary4, BuyStopOrderRequest(0.01, GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_35));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary5, BuyStopOrderRequest(0.01, GetSpreadRevOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSS_UNIQUE_COMMENT_36));

   return FullTradePool;
}

namespace _AnonymousFiveLevelNetShortFreeStylingFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   FiveLevelNetShortFreeStylingFactory AnonymousFiveLevelNetShortFreeStylingFactory;
}