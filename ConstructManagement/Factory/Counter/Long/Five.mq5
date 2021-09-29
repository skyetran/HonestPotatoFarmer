#property strict

#include "../../../../ConstructManagement/Factory/Counter/Long/Five.mqh"

namespace _AnonymousFiveLevelNetLongCounterConstructNameSpace {
   // Create The Construct Object To Register The Type At Run Time
   FiveLevelNetLongCounterConstruct AnonymousFiveLevelNetLongCounterConstruct;
}

//--- Constructor
//--- Call To Register Type
FiveLevelNetLongCounterFactory::FiveLevelNetLongCounterFactory(void) {
   Type = _AnonymousFiveLevelNetLongCounterConstructNameSpace::AnonymousFiveLevelNetLongCounterConstruct.GetConstructType();
   Construct::RegisterFactory(Type, GetPointer(this));
}

//--- Operations
ConstructPreCheckInfo *FiveLevelNetLongCounterFactory::PreCheck(ConstructParameters *InputParameters) {
   return new ConstructPreCheckInfo(GetMaxLotSizeExposure(InputParameters, FIVE_LEVEL),
                                    GetPersistingLotSizeExposure(InputParameters, FIVE_LEVEL),
                                    GetMaxPotentialLossInMinLotPointValue(InputParameters, FIVE_LEVEL));
}

bool FiveLevelNetLongCounterFactory::Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   return IsFiveLevel(InputParameters)                                       &&
          IsNetLong(InputParameters)                                         &&
          IsAttributeValidFundamentally(InputParameters, InputEntryPositionID);
}

Construct *FiveLevelNetLongCounterFactory::Create(ConstructParameters *InputParameters, const int InputEntryPositionID) {
   FiveLevelNetLongCounterConstruct *NewConstruct = new FiveLevelNetLongCounterConstruct();
   LogCoreInformation(NewConstruct, InputParameters, InputEntryPositionID);
   NewConstruct.SetFullTradePool(CreateFullTradePool(InputParameters));
   return NewConstruct;
}

//--- Helper Functions: Create Operation
ConstructFullTradePool *FiveLevelNetLongCounterFactory::CreateFullTradePool(ConstructParameters *InputParameters) {
   ConstructFullTradePool *FullTradePool = new ConstructFullTradePool();
   
   //--- Base Entry Order
   ExecutionBoundary *BaseEntryBoundary = new ExecutionBoundary(GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - PMHP.GetSlippageInPrice() - InputParameters.GetIntervalSizeInPrice(), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO)) - PMHP.GetSlippageInPrice());
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, FIVE_LEVEL)));
   FullTradePool.AddOneTimeRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, FIVE_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE)));
   
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(FOUR_LEVEL , InputParameters, FIVE_LEVEL)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(THREE_LEVEL, InputParameters, FIVE_LEVEL)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, FIVE_LEVEL)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, FIVE_LEVEL)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyRawMarketOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, FIVE_LEVEL)));
   
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(FOUR_LEVEL , InputParameters, FIVE_LEVEL), GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(THREE_LEVEL, InputParameters, FIVE_LEVEL), GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, FIVE_LEVEL), GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, FIVE_LEVEL), GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, FIVE_LEVEL), GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   
   //--- Counter Entry Order
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_ONE)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ZERO))));
   
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_TWO)  , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_ONE))));

   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_THREE), GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_TWO))));

   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FOUR)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FOUR) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_THREE))));

   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, SellLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FIVE)));
   FullTradePool.AddRecurrentRequest(BaseEntryBoundary, BuyStopLimitOrderRequest(MIN_LOT_SIZE, GetNLevelPrice(InputParameters, LEVEL_FIVE) , GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_FOUR))));

   //--- Stop Loss Order
   ExecutionBoundary *OutOfBoundStopLossBoundary = new ExecutionBoundary(GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)) - InputParameters.GetIntervalSizeInPrice(), GetStopLevelLowerOffsetPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND)));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   FullTradePool.AddOneTimeRequest(OutOfBoundStopLossBoundary, BuyStopOrderRequest(MIN_LOT_SIZE, GetSpreadOffsetBuyOrderPriceEntry(GetNLevelPrice(InputParameters, LEVEL_OUT_OF_BOUND))));
   
   ExecutionBoundary *StopLossBoundary = new ExecutionBoundary(GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())), GetStopLevelUpperOffsetPriceEntry(GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())) + InputParameters.GetIntervalSizeInPrice());
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredAllCoveredCounterLotSize(InputParameters, FIVE_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(FOUR_LEVEL , InputParameters, FIVE_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(THREE_LEVEL, InputParameters, FIVE_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(TWO_LEVEL  , InputParameters, FIVE_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(ONE_LEVEL  , InputParameters, FIVE_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())));
   FullTradePool.AddOneTimeRequest(StopLossBoundary, SellStopOrderRequest(GetCoveredCounterLotSizeNLevel(ZERO_LEVEL , InputParameters, FIVE_LEVEL), GetSpreadOffsetBuyOrderPriceEntry(InputParameters.GetStopLossLevel())));
   
   return FullTradePool;
}

namespace _AnonymousFiveLevelNetLongCounterFactoryNameSpace {
   // Create The Construct Factory Object To Register The Type At Run Time
   FiveLevelNetLongCounterFactory AnonymousFiveLevelNetLongCounterFactory;
}