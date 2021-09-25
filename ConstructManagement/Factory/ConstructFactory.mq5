#property strict

#include "../../ConstructManagement/Factory/ConstructFactory.mqh"

//--- Constructor
ConstructFactory::ConstructFactory(void) {
   GS   = GeneralSettings::GetInstance();
   IP   = IndicatorProcessor::GetInstance();
   PMHP = PositionManagementHyperParameters::GetInstance();
}

//--- Helper Functions: Validate Operation
bool ConstructFactory::IsAttributeValidFundamentally(ConstructParameters *InputParameters, const int InputEntryPositionID) const {
   return IsParametersValidFundamentally(InputParameters)         &&
          IsEntryPositionIDValidFundamentally(InputEntryPositionID);
}

bool ConstructFactory::IsParametersValidFundamentally(ConstructParameters *InputParameters) const {
   return InputParameters.GetCapstoneLevel()     > 0 &&
          InputParameters.GetApexLevel()         > 0 &&
          InputParameters.GetStopLossLevel()     > 0 &&
          InputParameters.GetIntervalSizeInPts() > 0  ;    
}

bool ConstructFactory::IsEntryPositionIDValidFundamentally(const int InputEntryPositionID) const {
   return InputEntryPositionID > 0;
}

bool ConstructFactory::IsNetLong(ConstructParameters *InputParameters) const {
   return InputParameters.GetApexLevel()     >= InputParameters.GetStopLossLevel() &&
          InputParameters.GetApexLevel()     >= InputParameters.GetCapstoneLevel() &&
          InputParameters.GetStopLossLevel() <= InputParameters.GetCapstoneLevel()  ;
}

bool ConstructFactory::IsNetShort(ConstructParameters *InputParameters) const {
   return InputParameters.GetApexLevel()     <= InputParameters.GetStopLossLevel() &&
          InputParameters.GetApexLevel()     <= InputParameters.GetCapstoneLevel() &&
          InputParameters.GetStopLossLevel() >= InputParameters.GetCapstoneLevel()  ;
}

bool ConstructFactory::IsThreeLevel(ConstructParameters *InputParameters) const {
   return THREE_LEVEL <= GetConstructLevel(InputParameters) <= FOUR_LEVEL;
}

bool ConstructFactory::IsFourLevel(ConstructParameters *InputParameters) const {
   return FOUR_LEVEL  <= GetConstructLevel(InputParameters) <= FIVE_LEVEL;
}

bool ConstructFactory::IsFiveLevel(ConstructParameters *InputParameters) const {
   return FIVE_LEVEL  <= GetConstructLevel(InputParameters) <= SIX_LEVEL;
}

bool ConstructFactory::IsSixLevel(ConstructParameters *InputParameters) const {
   return SIX_LEVEL   <= GetConstructLevel(InputParameters) <= SEVEN_LEVEL;
}

bool ConstructFactory::IsSevenLevel(ConstructParameters *InputParameters) const {
   return GetConstructLevel(InputParameters) >= SEVEN_LEVEL;
}

int ConstructFactory::GetConstructLevel(ConstructParameters* InputParameters) const {
   return GetConstructHeightInPts(InputParameters) / InputParameters.GetIntervalSizeInPts();
}

int ConstructFactory::GetConstructHeightInPts(ConstructParameters *InputParameters) const {
   return PriceToPointCvt(GetConstructHeightInPrice(InputParameters));
}

double ConstructFactory::GetConstructHeightInPrice(ConstructParameters *InputParameters) const {
   if (IsUpperConstruct(InputParameters)) {
      return MathAbs(InputParameters.GetApexLevel() - InputParameters.GetCapstoneLevel());
   }
   return MathAbs(InputParameters.GetCapstoneLevel() - InputParameters.GetStopLossLevel());
}

//--- Helper Functions: Create Operation
void ConstructFactory::LogCoreInformation(Construct *NewConstruct, ConstructParameters *InputParameters, const int InputEntryPositionID) {
   NewConstruct.SetConstructKey(new ConstructKey(Type, InputParameters, InputEntryPositionID));
   NewConstruct.SetConstructParameters(InputParameters);
   NewConstruct.SetEntryPositionID(InputEntryPositionID);
}

double ConstructFactory::GetNLevelPrice(ConstructParameters *InputParameters, const int Level) {
   double NLevelPrice = INVALID;
    
   if (IsLevelValid(Level)) {
      if (Level == 0) {
         NLevelPrice = InputParameters.GetCapstoneLevel();
      } else {
         if (IsUpperConstruct(InputParameters)) {
            NLevelPrice = GetNLevelPriceUpperConstruct(InputParameters, Level);
         } else {
            NLevelPrice = GetNLevelPriceLowerConstruct(InputParameters, Level);
         }
      }
   } else if (IsLevelOutOfBound(Level)) {
      NLevelPrice = GetOutOfBoundPrice(InputParameters);
   }
   return NLevelPrice;
}

double ConstructFactory::GetNLevelPriceUpperConstruct(ConstructParameters *InputParameters, const int Level) {
   if (IsNetLong(InputParameters)) {
      return InputParameters.GetCapstoneLevel() + Level * InputParameters.GetIntervalSizeInPrice();
   }
   return InputParameters.GetCapstoneLevel() - Level * InputParameters.GetIntervalSizeInPrice();
}

double ConstructFactory::GetNLevelPriceLowerConstruct(ConstructParameters *InputParameters, const int Level) {
   if (IsNetLong(InputParameters)) {
      return InputParameters.GetCapstoneLevel() - Level * InputParameters.GetIntervalSizeInPrice();
   }
   return InputParameters.GetCapstoneLevel() + Level * InputParameters.GetIntervalSizeInPrice();
}

double ConstructFactory::GetOutOfBoundPrice(ConstructParameters *InputParameters) {
   if (IsNetLong(InputParameters)) {
      return InputParameters.GetApexLevel() + PMHP.GetOutOfBoundBufferInPrice();
   }
   return InputParameters.GetApexLevel() - PMHP.GetOutOfBoundBufferInPrice();
}

double ConstructFactory::GetSpreadOffsetBuyOrderPriceEntry(const double OriginalPriceEntry) const {
   return OriginalPriceEntry - IP.GetAverageSpreadInPrice(CURRENT_BAR);
}

double ConstructFactory::GetSpreadOffsetSellOrderPriceEntry(const double OriginalPriceEntry) const {
   return OriginalPriceEntry + IP.GetAverageSpreadInPrice(CURRENT_BAR);
}

double ConstructFactory::GetStopLevelUpperOffsetPriceEntry(const double OriginalPriceEntry) const {
   return OriginalPriceEntry + IP.GetTradeStopLevelInPrice();
}

double ConstructFactory::GetStopLevelLowerOffsetPriceEntry(const double OriginalPriceEntry) const {
   return OriginalPriceEntry - IP.GetTradeStopLevelInPrice();
}

double ConstructFactory::GetStopLevelSlippageUpperOffsetPriceEntry(const double OriginalPriceEntry) const {
   return GetStopLevelUpperOffsetPriceEntry(OriginalPriceEntry) + PMHP.GetSlippageInPrice();
}

double ConstructFactory::GetStopLevelSlippageLowerOffsetPriceEntry(const double OriginalPriceEntry) const {
   return GetStopLevelLowerOffsetPriceEntry(OriginalPriceEntry) - PMHP.GetSlippageInPrice();
}

//--- Raw Base Entry Orders (Big Hedge)
MqlTradeRequestWrapper *ConstructFactory::BuyRawMarketOrderRequest(const double volume) {
   MqlTradeRequest request = {};
   
   request.action    = TRADE_ACTION_DEAL;
   request.magic     = GS.GetMagicNumber();
   request.symbol    = Symbol();
   request.deviation = PMHP.GetSlippageInPts();
   request.type      = ORDER_TYPE_BUY;
   
   request.volume    = volume;
   request.price     = NormalizeDouble(IP.GetAskPrice(CURRENT_BAR), Digits());
   
   return new MqlTradeRequestWrapper(request);
}

//--- Raw Base Entry Orders (Big Hedge)
MqlTradeRequestWrapper *ConstructFactory::SellRawMarketOrderRequest(const double volume) {
   MqlTradeRequest request = {};
   
   request.action    = TRADE_ACTION_DEAL;
   request.magic     = GS.GetMagicNumber();
   request.symbol    = Symbol();
   request.deviation = PMHP.GetSlippageInPts();
   request.type      = ORDER_TYPE_SELL;
   
   request.volume    = volume;
   request.price     = NormalizeDouble(IP.GetBidPrice(CURRENT_BAR), Digits());
   
   return new MqlTradeRequestWrapper(request);
}

//--- Base Entry Orders
MqlTradeRequestWrapper *ConstructFactory::BuyMarketOrderRequest(const double volume) {
   MqlTradeRequest request = {};
   
   request.action    = TRADE_ACTION_DEAL;
   request.magic     = GS.GetMagicNumber();
   request.symbol    = Symbol();
   request.deviation = PMHP.GetSlippageInPts();
   request.type      = ORDER_TYPE_BUY;
   
   request.volume    = volume;
   request.price     = NormalizeDouble(GetSpreadOffsetBuyOrderPriceEntry(GetSlippageOffsetBuyOrderPriceEntry(IP.GetAskPrice(CURRENT_BAR))), Digits());
   
   return new MqlTradeRequestWrapper(request);
}

//--- Base Entry Orders
MqlTradeRequestWrapper *ConstructFactory::SellMarketOrderRequest(const double volume) {
   MqlTradeRequest request = {};
   
   request.action    = TRADE_ACTION_DEAL;
   request.magic     = GS.GetMagicNumber();
   request.symbol    = Symbol();
   request.deviation = PMHP.GetSlippageInPts();
   request.type      = ORDER_TYPE_SELL;
   
   request.volume    = volume;
   request.price     = NormalizeDouble(GetSlippageOffsetSellOrderPriceEntry(IP.GetBidPrice(CURRENT_BAR)), Digits());
   
   return new MqlTradeRequestWrapper(request);
}

//--- Limit Entry Orders
MqlTradeRequestWrapper *ConstructFactory::BuyLimitOrderRequest(const double volume, const double price) {
   MqlTradeRequest request = {};
   
   request.action    = TRADE_ACTION_PENDING;
   request.magic     = GS.GetMagicNumber();
   request.symbol    = Symbol();
   request.deviation = PMHP.GetSlippageInPts();
   request.type      = ORDER_TYPE_BUY_LIMIT;
   
   request.volume    = volume;
   request.price     = NormalizeDouble(price, Digits());
   
   return new MqlTradeRequestWrapper(request);
}

//--- Limit Entry Orders
MqlTradeRequestWrapper *ConstructFactory::SellLimitOrderRequest(const double volume, const double price) {
   MqlTradeRequest request = {};
   
   request.action    = TRADE_ACTION_PENDING;
   request.magic     = GS.GetMagicNumber();
   request.symbol    = Symbol();
   request.deviation = PMHP.GetSlippageInPts();
   request.type      = ORDER_TYPE_SELL_LIMIT;
   
   request.volume    = volume;
   request.price     = NormalizeDouble(price, Digits());
   
   return new MqlTradeRequestWrapper(request);
}

//--- Stop Limit Entry Orders
MqlTradeRequestWrapper *ConstructFactory::BuyStopLimitOrderRequest(const double volume, const double price, const double stoplimit) {
   MqlTradeRequest request = {};
   
   request.action    = TRADE_ACTION_PENDING;
   request.magic     = GS.GetMagicNumber();
   request.symbol    = Symbol();
   request.deviation = PMHP.GetSlippageInPts();
   request.type      = ORDER_TYPE_BUY_LIMIT;
   
   request.volume    = volume;
   request.price     = NormalizeDouble(price, Digits());
   request.stoplimit = NormalizeDouble(price, Digits());
   
   return new MqlTradeRequestWrapper(request);
}

//--- Stop Limit Entry Orders
MqlTradeRequestWrapper *ConstructFactory::SellStopLimitOrderRequest(const double volume, const double price, const double stoplimit) {
   MqlTradeRequest request = {};
   
   request.action    = TRADE_ACTION_PENDING;
   request.magic     = GS.GetMagicNumber();
   request.symbol    = Symbol();
   request.deviation = PMHP.GetSlippageInPts();
   request.type      = ORDER_TYPE_SELL_LIMIT;
   
   request.volume    = volume;
   request.price     = NormalizeDouble(price, Digits());
   request.stoplimit = NormalizeDouble(price, Digits());
   
   return new MqlTradeRequestWrapper(request);
}

//--- Stop Orders
MqlTradeRequestWrapper *ConstructFactory::BuyStopOrderRequest(const double volume, const double price) {
   MqlTradeRequest request = {};
   
   request.action    = TRADE_ACTION_PENDING;
   request.magic     = GS.GetMagicNumber();
   request.symbol    = Symbol();
   request.deviation = PMHP.GetSlippageInPts();
   request.type      = ORDER_TYPE_BUY_STOP;
   
   request.volume    = volume;
   request.price     = NormalizeDouble(price, Digits());
   
   return new MqlTradeRequestWrapper(request);
}

//--- Stop Orders
MqlTradeRequestWrapper *ConstructFactory::SellStopOrderRequest(const double volume, const double price) {
   MqlTradeRequest request = {};
   
   request.action    = TRADE_ACTION_PENDING;
   request.magic     = GS.GetMagicNumber();
   request.symbol    = Symbol();
   request.deviation = PMHP.GetSlippageInPts();
   request.type      = ORDER_TYPE_SELL_STOP;
   
   request.volume    = volume;
   request.price     = NormalizeDouble(price, Digits());
   
   return new MqlTradeRequestWrapper(request);
}

double ConstructFactory::GetSlippageOffsetBuyOrderPriceEntry(const double OriginalPriceEntry) const {
   return OriginalPriceEntry - PMHP.GetSlippageInPrice();
}

double ConstructFactory::GetSlippageOffsetSellOrderPriceEntry(const double OriginalPriceEntry) const {
   return OriginalPriceEntry + PMHP.GetSlippageInPrice();
}

//--- Classifier: Upper Construct (Counter & FreeStyling) Or Lower Construct (BigHedge)
bool ConstructFactory::IsUpperConstruct(ConstructParameters *InputParameters) const {
   return InputParameters.GetApexLevel() != InputParameters.GetCapstoneLevel();
}

//--- Other Auxilary Functions
bool ConstructFactory::IsLevelValid(const int InputLevel) const {
   return 0 <= InputLevel && InputLevel <= MAX_CONSTRUCT_LEVEL;
}

bool ConstructFactory::IsLevelOutOfBound(const int InputLevel) const {
   return InputLevel == LEVEL_OUT_OF_BOUND;
}