#property strict

#include "../../../../ConstructManagement/Factory/FreeStyling/Long/Six.mqh"

namespace _AnonymousSixLevelNetLongFreeStylingConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetLongFreeStylingConstruct AnonymousSixLevelNetLongFreeStylingConstruct;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetLongFreeStylingFactory::SixLevelNetLongFreeStylingFactory(void) {
   UniqueFactoryComment = "hHGCHgHUtZAhkJX8QMd1";
   Type = _AnonymousSixLevelNetLongFreeStylingConstructNameSpace::AnonymousSixLevelNetLongFreeStylingConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SixLevelNetLongFreeStylingFactory::PreCheck(ConstructParameters *InputParameters) {
   return new ConstructPreCheckInfo(GetMaxLotSizeExposure(InputParameters, SIX_LEVEL),
                                    GetPersistingLotSizeExposure(InputParameters, SIX_LEVEL),
                                    GetMaxPotentialLossInMinLotPointValue(InputParameters, SIX_LEVEL));
}

bool SixLevelNetLongFreeStylingFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsSixLevel(InputParameters)                                        &&
          IsNetLong(InputParameters)                                         &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *SixLevelNetLongFreeStylingFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   SixLevelNetLongFreeStylingConstruct *NewConstruct = new SixLevelNetLongFreeStylingConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SixLevelNetLongFreeStylingFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - InputParameters.GetIntervalSizeInPrice() - PMHP.GetSlippageInPrice(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - PMHP.GetSlippageInPrice());
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredAllCoveredRetracementLotSize(InputParameters, SIX_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ZERO) - PMHP.GetSlippageInPrice(), UniqueFactoryComment + FSL_UNIQUE_COMMENT_01));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredAllCoveredRetracementLotSize(InputParameters, SIX_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE), UniqueFactoryComment + FSL_UNIQUE_COMMENT_02));
   
   CompletionBoundary *BaseExitBoundary1 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ZERO , InputParameters), GetNLevelPrice(InputParameters, LEVEL_ZERO) - PMHP.GetSlippageInPrice(), UniqueFactoryComment + FSL_UNIQUE_COMMENT_03), BaseExitBoundary1);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(   LEVEL_ZERO , InputParameters), GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + FSL_UNIQUE_COMMENT_04), BaseExitBoundary1);
 
   CompletionBoundary *BaseExitBoundary2 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ONE  , InputParameters), GetNLevelPrice(InputParameters, LEVEL_ZERO) - PMHP.GetSlippageInPrice(), UniqueFactoryComment + FSL_UNIQUE_COMMENT_05), BaseExitBoundary2);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(   LEVEL_ONE  , InputParameters), GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + FSL_UNIQUE_COMMENT_06), BaseExitBoundary2);
   
   CompletionBoundary *BaseExitBoundary3 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_TWO  , InputParameters), GetNLevelPrice(InputParameters, LEVEL_ZERO) - PMHP.GetSlippageInPrice(), UniqueFactoryComment + FSL_UNIQUE_COMMENT_07), BaseExitBoundary3);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(   LEVEL_TWO  , InputParameters), GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + FSL_UNIQUE_COMMENT_08), BaseExitBoundary3);

   CompletionBoundary *BaseExitBoundary4 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_THREE, InputParameters), GetNLevelPrice(InputParameters, LEVEL_ZERO) - PMHP.GetSlippageInPrice(), UniqueFactoryComment + FSL_UNIQUE_COMMENT_09), BaseExitBoundary4);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(   LEVEL_THREE, InputParameters), GetNLevelPrice(InputParameters, LEVEL_FOUR) , UniqueFactoryComment + FSL_UNIQUE_COMMENT_10), BaseExitBoundary4);

   CompletionBoundary *BaseExitBoundary5 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_FOUR , InputParameters), GetNLevelPrice(InputParameters, LEVEL_ZERO) - PMHP.GetSlippageInPrice(), UniqueFactoryComment + FSL_UNIQUE_COMMENT_11), BaseExitBoundary5);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(   LEVEL_FOUR , InputParameters), GetNLevelPrice(InputParameters, LEVEL_FIVE) , UniqueFactoryComment + FSL_UNIQUE_COMMENT_12), BaseExitBoundary5);         

   CompletionBoundary *BaseExitBoundary6 = new CompletionBoundary(GetNLevelPrice(InputParameters, LEVEL_SIX)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_FIVE , InputParameters), GetNLevelPrice(InputParameters, LEVEL_ZERO) - PMHP.GetSlippageInPrice(), UniqueFactoryComment + FSL_UNIQUE_COMMENT_13), BaseExitBoundary6);
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredRetracementLotSizeNLevel(   LEVEL_FIVE , InputParameters), GetNLevelPrice(InputParameters, LEVEL_SIX)  , UniqueFactoryComment + FSL_UNIQUE_COMMENT_14), BaseExitBoundary6); 

   //--- Retracement Entry Order
   ExecutionBoundary  *RetracementEntryBoundary0 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   CompletionBoundary *RetracementExitBoundary0  = new CompletionBoundary(InputParameters.GetStopLossLevel(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO) - InputParameters.GetIntervalSizeInPrice()));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary0, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ZERO) - InputParameters.GetIntervalSizeInPrice(), UniqueFactoryComment + FSL_UNIQUE_COMMENT_15), RetracementExitBoundary0);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary0, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO) - InputParameters.GetIntervalSizeInPrice()), GetNLevelPrice(InputParameters, LEVEL_ZERO), UniqueFactoryComment + FSL_UNIQUE_COMMENT_16), RetracementExitBoundary0);

   ExecutionBoundary  *RetracementEntryBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   CompletionBoundary *RetracementExitBoundary1  = new CompletionBoundary(InputParameters.GetStopLossLevel(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary1, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ZERO) , UniqueFactoryComment + FSL_UNIQUE_COMMENT_17), RetracementExitBoundary1);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary1, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) , GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + FSL_UNIQUE_COMMENT_18), RetracementExitBoundary1);
   
   ExecutionBoundary  *RetracementEntryBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   CompletionBoundary *RetracementExitBoundary2  = new CompletionBoundary(InputParameters.GetStopLossLevel(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary2, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)  , UniqueFactoryComment + FSL_UNIQUE_COMMENT_19), RetracementExitBoundary2);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary2, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))  , GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + FSL_UNIQUE_COMMENT_20), RetracementExitBoundary2);
   
   ExecutionBoundary  *RetracementEntryBoundary3 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   CompletionBoundary *RetracementExitBoundary3  = new CompletionBoundary(InputParameters.GetStopLossLevel(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary3, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)  , UniqueFactoryComment + FSL_UNIQUE_COMMENT_21), RetracementExitBoundary3);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary3, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))  , GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + FSL_UNIQUE_COMMENT_22), RetracementExitBoundary3);
   
   ExecutionBoundary  *RetracementEntryBoundary4 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   CompletionBoundary *RetracementExitBoundary4  = new CompletionBoundary(InputParameters.GetStopLossLevel(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary4, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE), UniqueFactoryComment + FSL_UNIQUE_COMMENT_23), RetracementExitBoundary4);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary4, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)), GetNLevelPrice(InputParameters, LEVEL_FOUR) , UniqueFactoryComment + FSL_UNIQUE_COMMENT_24), RetracementExitBoundary4);
   
   ExecutionBoundary  *RetracementEntryBoundary5 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   CompletionBoundary *RetracementExitBoundary5  = new CompletionBoundary(InputParameters.GetStopLossLevel(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary5, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FOUR) , UniqueFactoryComment + FSL_UNIQUE_COMMENT_25), RetracementExitBoundary5);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary5, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)) , GetNLevelPrice(InputParameters, LEVEL_FIVE) , UniqueFactoryComment + FSL_UNIQUE_COMMENT_26), RetracementExitBoundary5);
   
   ExecutionBoundary  *RetracementEntryBoundary6 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_SIX)  , GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND));
   CompletionBoundary *RetracementExitBoundary6  = new CompletionBoundary(InputParameters.GetStopLossLevel(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary6, BuyLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FIVE) , UniqueFactoryComment + FSL_UNIQUE_COMMENT_27), RetracementExitBoundary6);
   FullTradePool.AddRecurrentRequest(RetracementEntryBoundary6, SellStopLimitOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)) , GetNLevelPrice(InputParameters, LEVEL_SIX)  , UniqueFactoryComment + FSL_UNIQUE_COMMENT_28), RetracementExitBoundary6);
   
   //--- Stop Loss Order
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())), GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredAllCoveredRetracementLotSize(InputParameters, SIX_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_29));
   
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ZERO , InputParameters), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_30));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_ONE  , InputParameters), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_31));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_TWO  , InputParameters), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_32));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_THREE, InputParameters), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_33));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_FOUR , InputParameters), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_34));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredRetracementLotSizeNLevel(LEVEL_FIVE , InputParameters), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_35));
   
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary0, SellStopOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_36));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary1, SellStopOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_37));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary2, SellStopOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_38));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary3, SellStopOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_39));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary4, SellStopOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_40));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary5, SellStopOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_41));
   FullTradePool.AddOneTimeRequest(RetracementEntryBoundary6, SellStopOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel()), UniqueFactoryComment + FSL_UNIQUE_COMMENT_42));
   
   return FullTradePool;
}

namespace _AnonymousSixLevelNetLongFreeStylingFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   SixLevelNetLongFreeStylingFactory AnonymousSixLevelNetLongFreeStylingFactory;
}