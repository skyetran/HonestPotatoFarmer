#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Short/Six.mqh"

namespace _AnonymousSixLevelNetShortBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   SixLevelNetShortBigHedgeConstruct AnonymousSixLevelNetShortBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
SixLevelNetShortBigHedgeFactory::SixLevelNetShortBigHedgeFactory(void) {
   Type = _AnonymousSixLevelNetShortBigHedgeConstructNameSpace::AnonymousSixLevelNetShortBigHedgeConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *SixLevelNetShortBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   int DeathZoneSize = PriceToPointCvt(MathAbs(GetNLevelPrice(InputParameters, LEVEL_SIX) - InputParameters.GetStopLossLevel()));
   int MaxPotentialLossInMinLotPointValue = 12 * IP.GetAverageSpreadInPts(CURRENT_BAR) + 30 * InputParameters.GetIntervalSizeInPts() + 12 * DeathZoneSize;
   return new ConstructPreCheckInfo(0.12, 0.12, MaxPotentialLossInMinLotPointValue);
}

bool SixLevelNetShortBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsSixLevel(InputParameters)                                        &&
          IsNetShort(InputParameters)                                        &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *SixLevelNetShortBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   SixLevelNetShortBigHedgeConstruct *NewConstruct = new SixLevelNetShortBigHedgeConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *SixLevelNetShortBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - PMHP.GetSlippageInPrice(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRequest(BaseEntryBoundary, SellRawMarketOrderRequest(0.06));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyRawMarketOrderRequest( 0.01));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyRawMarketOrderRequest( 0.01));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyRawMarketOrderRequest( 0.01));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyRawMarketOrderRequest( 0.01));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyRawMarketOrderRequest( 0.01));
   FullTradePool.AddRequest(BaseEntryBoundary, BuyRawMarketOrderRequest( 0.01));
   
   //--- Retracement Entry Order
   ExecutionBoundary *RetracementEntryBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRequest(RetracementEntryBoundary1, SellLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_ONE)));

   ExecutionBoundary *RetracementEntryBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRequest(RetracementEntryBoundary2, SellLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_TWO)));
   
   ExecutionBoundary *RetracementEntryBoundary3 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRequest(RetracementEntryBoundary3, SellLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_THREE)));
   
   ExecutionBoundary *RetracementEntryBoundary4 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   FullTradePool.AddRequest(RetracementEntryBoundary4, SellLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   
   ExecutionBoundary *RetracementEntryBoundary5 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   FullTradePool.AddRequest(RetracementEntryBoundary5, SellLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   
   ExecutionBoundary *RetracementEntryBoundary6 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SIX)));
   FullTradePool.AddRequest(RetracementEntryBoundary6, SellLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_SIX)));
   
   //--- Counter Entry Order
   ExecutionBoundary *CounterEntryBoundary = new ExecutionBoundary(InputParameters.GetApexLevel(), InputParameters.GetStopLossLevel());
   FullTradePool.AddRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_THREE), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(CounterEntryBoundary, BuyStopLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_SIX)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   
   //--- Take Profit Order
   ExecutionBoundary *RetracementTakeProfitBoundary = new ExecutionBoundary(InputParameters.GetApexLevel(), InputParameters.GetStopLossLevel());
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_THREE), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE))));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR))));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, BuyStopLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_SIX)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE))));
   
   ExecutionBoundary *CounterTakeProfitBoundary1 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRequest(CounterTakeProfitBoundary1, SellLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_ONE)));
   
   ExecutionBoundary *CounterTakeProfitBoundary2 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRequest(CounterTakeProfitBoundary2, SellLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_TWO)));
   
   ExecutionBoundary *CounterTakeProfitBoundary3 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRequest(CounterTakeProfitBoundary3, SellLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_THREE)));
   
   ExecutionBoundary *CounterTakeProfitBoundary4 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_THREE), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   FullTradePool.AddRequest(CounterTakeProfitBoundary4, SellLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   
   ExecutionBoundary *CounterTakeProfitBoundary5 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   FullTradePool.AddRequest(CounterTakeProfitBoundary5, SellLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   
   ExecutionBoundary *CounterTakeProfitBoundary6 = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_SIX)));
   FullTradePool.AddRequest(CounterTakeProfitBoundary6, SellLimitOrderRequest(0.01, GetNLevelPrice(InputParameters, LEVEL_SIX)));
   
   //--- Stop Loss Order
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_SIX), GetStopLevelLowerOffsetPriceEntry(InputParameters.GetStopLossLevel()));
   FullTradePool.AddRequest(StopLossBoundary, BuyStopOrderRequest(0.12, InputParameters.GetStopLossLevel()));
   
   return FullTradePool;
}

namespace _AnonymousSixLevelNetShortBigHedgeFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   SixLevelNetShortBigHedgeFactory AnonymousSixLevelNetShortBigHedgeFactory;
}