#property strict

#include "../../../../ConstructManagement/Factory/Counter/Long/Two.mqh"

namespace _AnonymousTwoLevelNetLongCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   TwoLevelNetLongCounterConstruct AnonymousTwoLevelNetLongCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
TwoLevelNetLongCounterFactory::TwoLevelNetLongCounterFactory(void) {
   Type = _AnonymousTwoLevelNetLongCounterConstructNameSpace::AnonymousTwoLevelNetLongCounterConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *TwoLevelNetLongCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return new ConstructPreCheckInfo(GetMaxLotSizeExposure(InputParameters, TWO_LEVEL),
                                    GetPersistingLotSizeExposure(InputParameters, TWO_LEVEL),
                                    GetMaxPotentialLossInMinLotPointValue(InputParameters, TWO_LEVEL));
}

bool TwoLevelNetLongCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsTwoLevel(InputParameters)                                        &&
          IsNetLong(InputParameters)                                         &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *TwoLevelNetLongCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   TwoLevelNetLongCounterConstruct *NewConstruct = new TwoLevelNetLongCounterConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *TwoLevelNetLongCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - PMHP.GetSlippageInPrice() - InputParameters.GetIntervalSizeInPrice(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - PMHP.GetSlippageInPrice());
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, TWO_LEVEL)));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, TWO_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE)));
   
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL , InputParameters, TWO_LEVEL)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL, InputParameters, TWO_LEVEL)));
   
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL , InputParameters, TWO_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL, InputParameters, TWO_LEVEL), GetNLevelPrice(InputParameters, LEVEL_TWO)));
   
   //--- Counter Entry Order
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));

   //--- Stop Loss Order
   ExecutionBoundary *OutOfBoundStopLossBoundary = new ExecutionBoundary(GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)) - InputParameters.GetIntervalSizeInPrice(), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())), GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, TWO_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL , InputParameters, TWO_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL, InputParameters, TWO_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())));
   
   return FullTradePool;
}

namespace _AnonymousTwoLevelNetLongCounterFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   TwoLevelNetLongCounterFactory AnonymousTwoLevelNetLongCounterFactory;
}