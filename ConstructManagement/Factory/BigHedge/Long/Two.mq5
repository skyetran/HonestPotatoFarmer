#property strict

#include "../../../../ConstructManagement/Factory/BigHedge/Long/Two.mqh"

namespace _AnonymousTwoLevelNetLongBigHedgeConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetLongBigHedgeConstruct AnonymousTwoLevelNetLongBigHedgeConstruct;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetLongBigHedgeFactory::TwoLevelNetLongBigHedgeFactory(void) {
   Type = _AnonymousTwoLevelNetLongBigHedgeConstructNameSpace::AnonymousTwoLevelNetLongBigHedgeConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *TwoLevelNetLongBigHedgeFactory::PreCheck(ConstructParameters *InputParameters) {
   int DeathZoneSize = PriceToPointCvt(MathAbs(GetNLevelPrice(InputParameters, LEVEL_TWO) - InputParameters.GetStopLossLevel()));
   int MaxPotentialLossInMinLotPointValue = 4 * IP.GetAverageSpreadInPts(CURRENT_BAR) + 2 * InputParameters.GetIntervalSizeInPts() + 4 * DeathZoneSize;
   return new ConstructPreCheckInfo(0.04, 0.04, MaxPotentialLossInMinLotPointValue);
}

bool TwoLevelNetLongBigHedgeFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsTwoLevel(InputParameters)                                        &&
          IsNetLong(InputParameters)                                         &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *TwoLevelNetLongBigHedgeFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   TwoLevelNetLongBigHedgeConstruct *NewConstruct = new TwoLevelNetLongBigHedgeConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *TwoLevelNetLongBigHedgeFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetNLevelPrice(InputParameters, LEVEL_ZERO), GetNLevelPrice(InputParameters, LEVEL_ZERO) + PMHP.GetSlippageInPrice());
   FullTradePool.AddRequest(BaseEntryBoundary, BuyRawMarketOrderRequest( 0.02));
   FullTradePool.AddRequest(BaseEntryBoundary, SellRawMarketOrderRequest(0.01));
   FullTradePool.AddRequest(BaseEntryBoundary, SellRawMarketOrderRequest(0.01));
   
   //--- Retracement Entry Order
   ExecutionBoundary *RetracementEntryBoundary1 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))), GetNLevelPrice(InputParameters, LEVEL_ZERO));
   FullTradePool.AddRequest(RetracementEntryBoundary1, BuyLimitOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));

   ExecutionBoundary *RetracementEntryBoundary2 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))), GetNLevelPrice(InputParameters, LEVEL_ONE));
   FullTradePool.AddRequest(RetracementEntryBoundary2, BuyLimitOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))));
   
   //--- Counter Entry Order
   ExecutionBoundary *CounterEntryBoundary = new ExecutionBoundary(InputParameters.GetStopLossLevel(), InputParameters.GetApexLevel());
   FullTradePool.AddRequest(CounterEntryBoundary, SellStopLimitOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)), GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRequest(CounterEntryBoundary, SellStopLimitOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)), GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   
   //--- Take Profit Order
   ExecutionBoundary *RetracementTakeProfitBoundary = new ExecutionBoundary(InputParameters.GetStopLossLevel(), InputParameters.GetApexLevel());
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, SellStopLimitOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE)), GetNLevelPrice(InputParameters, LEVEL_ZERO)));
   FullTradePool.AddRequest(RetracementTakeProfitBoundary, SellStopLimitOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO)), GetNLevelPrice(InputParameters, LEVEL_ONE)));
   
   ExecutionBoundary *CounterTakeProfitBoundary1 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))), GetNLevelPrice(InputParameters, LEVEL_ZERO));
   FullTradePool.AddRequest(CounterTakeProfitBoundary1, BuyLimitOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));
   
   ExecutionBoundary *CounterTakeProfitBoundary2 = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))), GetNLevelPrice(InputParameters, LEVEL_ONE));
   FullTradePool.AddRequest(CounterTakeProfitBoundary2, BuyLimitOrderRequest(0.01, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))));
   
   //--- Stop Loss Order
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())), GetNLevelPrice(InputParameters, LEVEL_TWO));
   FullTradePool.AddRequest(StopLossBoundary, SellStopOrderRequest(0.04, GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())));
   
   return FullTradePool;
}

namespace _AnonymousTwoLevelNetLongBigHedgeFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   TwoLevelNetLongBigHedgeFactory AnonymousTwoLevelNetLongBigHedgeFactory;
}