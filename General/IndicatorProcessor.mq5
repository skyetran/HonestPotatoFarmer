#property strict

#include "../General/IndicatorProcessor.mqh"

//--- Constructor
IndicatorProcessor::IndicatorProcessor(void) {
   ArraySetAsSeries(FastMAMA_Buffer    , true);
   ArraySetAsSeries(SlowMAMA_Buffer    , true);
   ArraySetAsSeries(FastFAMA_Buffer    , true);
   ArraySetAsSeries(SlowFAMA_Buffer    , true);
   ArraySetAsSeries(UpperSSB_Buffer    , true);
   ArraySetAsSeries(LowerSSB_Buffer    , true);
   ArraySetAsSeries(FilteredPriceBuffer, true);
   ArraySetAsSeries(BuyStopLossBuffer  , true);
   ArraySetAsSeries(SellStopLossBuffer , true);
   ArraySetAsSeries(OpenSpread         , true);
   ArraySetAsSeries(HighSpread         , true);
   ArraySetAsSeries(LowSpread          , true);
   ArraySetAsSeries(CloseSpread        , true);
   ArraySetAsSeries(AverageSpread      , true);
}

//--- Get Singleton Instance
IndicatorProcessor* IndicatorProcessor::GetInstance(void) {
   if (!Instance) {
      Instance = new IndicatorProcessor();
   }
   return Instance;
}

//--- Debug
string IndicatorProcessor::GetDebugMessage(void) {
   string Msg;
   Msg += "Fast MAMA: "      + DoubleToString(GetFastMAMA(CURRENT_BAR))            + "\n";
   Msg += "Fast FAMA: "      + DoubleToString(GetFastFAMA(CURRENT_BAR))            + "\n";
   Msg += "Slow MAMA: "      + DoubleToString(GetSlowMAMA(CURRENT_BAR))            + "\n";
   Msg += "Slow FAMA: "      + DoubleToString(GetSlowFAMA(CURRENT_BAR))            + "\n";
   Msg += "Upper SSB: "      + DoubleToString(GetUpperSSB(CURRENT_BAR))            + "\n";
   Msg += "Lower SSB: "      + DoubleToString(GetLowerSSB(CURRENT_BAR))            + "\n";
   Msg += "Filtered Price: " + DoubleToString(GetFilteredPrice(CURRENT_BAR))       + "\n";
   Msg += "Buy StopLoss: "   + DoubleToString(GetBuyStopLossLevel(CURRENT_BAR))    + "\n";
   Msg += "Sell StopLoss: "  + DoubleToString(GetSellStopLossLevel(CURRENT_BAR))   + "\n";
   Msg += "Open Spread: "    + IntegerToString(GetOpenSpreadInPts(CURRENT_BAR))    + "\n";
   Msg += "High Spread: "    + IntegerToString(GetHighSpreadInPts(CURRENT_BAR))    + "\n";
   Msg += "Low Spread: "     + IntegerToString(GetLowSpreadInPts(CURRENT_BAR))     + "\n";
   Msg += "Close Spread: "   + IntegerToString(GetCloseSpreadInPts(CURRENT_BAR))   + "\n";
   Msg += "Average Spread: " + DoubleToString(GetAverageSpreadInPts(CURRENT_BAR))  + "\n";
   Msg += "\n";
   Msg += "Difference Fast FAMA --- Slow FAMA: " + IntegerToString(GetDiffFastFAMA_SlowFAMA_Pts(CURRENT_BAR)) + "\n";
   Msg += "Stop Loss Volatility In Price: " + DoubleToString(GetStopLossVolatilityInPrice(CURRENT_BAR)) + "\n";
   Msg += "Take Profit Volatility In Price: " + DoubleToString(GetTakeProfitVolatilityInPrice(CURRENT_BAR)) + "\n";
   Msg += "Stop Loss Volatility In Pts: " + IntegerToString(GetStopLossVolatilityInPts(CURRENT_BAR)) + "\n";
   Msg += "Take Profit Volatility In Price: " + IntegerToString(GetTakeProfitVolatilityInPts(CURRENT_BAR)) + "\n";
   return Msg;
}

//--- Indicator Init
void IndicatorProcessor::FullInit(void) {
   FastMAMA_Handle    = iCustom(CurrencyPair, TimeFrame, "MAMA_FAMA", FastMAMA_FastLimit, FastMAMA_SlowLimit);
   SlowMAMA_Handle    = iCustom(CurrencyPair, TimeFrame, "MAMA_FAMA", SlowMAMA_FastLimit, SlowMAMA_SlowLimit);
   SSB_Handle         = iCustom(CurrencyPair, TimeFrame, "SuperSmoothBand", SSB_AttenuationPeriod, SSB_Alpha, SSB_Beta);
   SSB_StopLossHandle = iCustom(CurrencyPair, TimeFrame, "SuperSmoothBand", SSB_StopLossAttenuationPeriod, SSB_StopLossAlpha, SSB_StopLossBeta);
   SpreadHandle       = iCustom(CurrencyPair, TimeFrame, "Spread_Record");
}

//--- Setter
bool IndicatorProcessor::SetFastMAMAParameters(const double &FastLimit, const double &SlowLimit) {
   if (!IsMAMAValid(FastLimit, SlowLimit)) {
      return false;
   }
   FastMAMA_FastLimit = FastLimit;
   FastMAMA_SlowLimit = SlowLimit;
   return true;
}

//--- Setter
bool IndicatorProcessor::SetSlowMAMAParameters(const double &FastLimit, const double &SlowLimit) {
   if (!IsMAMAValid(FastLimit, SlowLimit)) {
      return false;
   }
   SlowMAMA_FastLimit = FastLimit;
   SlowMAMA_SlowLimit = SlowLimit;
   return true;
}

//--- Validation: MAMA Indicator Checker
bool IndicatorProcessor::IsMAMAValid(const double &FastLimit, const double &SlowLimit) {
   return FastLimit > MIN_MAMA_FAST_LIMIT && 
          SlowLimit > MIN_MAMA_SLOW_LIMIT && 
          FastLimit >= SlowLimit          ;
}

//--- Setter
bool IndicatorProcessor::SetSSBParameters(const int &AttenuationPeriod, const double &Alpha, const double &Beta) {
   if (!IsSSBValid(AttenuationPeriod, Alpha, Beta)) {
      return false;
   }   
   SSB_AttenuationPeriod = AttenuationPeriod;
   SSB_Alpha             = Alpha;
   SSB_Beta              = Beta;
   return true;
}

//--- Setter
bool IndicatorProcessor::SetSSBStopLossParameters(const int &AttenuationPeriod, const double &Alpha, const double &Beta) {
   if (!IsSSBValid(AttenuationPeriod, Alpha, Beta)) {
      return false;
   }   
   SSB_StopLossAttenuationPeriod = AttenuationPeriod;
   SSB_StopLossAlpha             = Alpha;
   SSB_StopLossBeta              = Beta;
   return true;
}

//--- Validation: SSB Indicator Checker
bool IndicatorProcessor::IsSSBValid(const int &AttenuationPeriod, const double &Alpha, const double &Beta) {
   return AttenuationPeriod >= MIN_ATTENUATION_PERIOD &&
          Alpha             >= MIN_ALPHA              &&
          Alpha             <= MAX_ALPHA              &&
          Beta              >= MIN_BETA               &&
          Beta              <= MAX_BETA               &&
          Alpha             <= Beta                   ;
}

//--- Update Indicator Buffer --- OnTick Function
void IndicatorProcessor::Update(void) {
   CopyBuffer(FastMAMA_Handle   , MAMA_BUFFER          , 0, INDICATOR_BUFFER_SIZE, FastMAMA_Buffer);
   CopyBuffer(SlowMAMA_Handle   , MAMA_BUFFER          , 0, INDICATOR_BUFFER_SIZE, SlowMAMA_Buffer);
   CopyBuffer(FastMAMA_Handle   , FAMA_BUFFER          , 0, INDICATOR_BUFFER_SIZE, FastFAMA_Buffer);
   CopyBuffer(SlowMAMA_Handle   , FAMA_BUFFER          , 0, INDICATOR_BUFFER_SIZE, SlowFAMA_Buffer);
   CopyBuffer(SSB_Handle        , SSB_UPPER_BAND       , 0, INDICATOR_BUFFER_SIZE, UpperSSB_Buffer);
   CopyBuffer(SSB_Handle        , SSB_LOWER_BAND       , 0, INDICATOR_BUFFER_SIZE, LowerSSB_Buffer);
   CopyBuffer(SSB_Handle        , SSB_MIDDLE_BAND      , 0, INDICATOR_BUFFER_SIZE, FilteredPriceBuffer);
   CopyBuffer(SSB_StopLossHandle, SSB_LOWER_BAND       , 0, INDICATOR_BUFFER_SIZE, BuyStopLossBuffer);
   CopyBuffer(SSB_StopLossHandle, SSB_UPPER_BAND       , 0, INDICATOR_BUFFER_SIZE, SellStopLossBuffer);
   CopyBuffer(SpreadHandle      , OPEN_SPREAD_BUFFER   , 0, INDICATOR_BUFFER_SIZE, OpenSpread);
   CopyBuffer(SpreadHandle      , HIGH_SPREAD_BUFFER   , 0, INDICATOR_BUFFER_SIZE, HighSpread);
   CopyBuffer(SpreadHandle      , LOW_SPREAD_BUFFER    , 0, INDICATOR_BUFFER_SIZE, LowSpread);
   CopyBuffer(SpreadHandle      , CLOSE_SPREAD_BUFFER  , 0, INDICATOR_BUFFER_SIZE, CloseSpread);
   CopyBuffer(SpreadHandle      , AVERAGE_SPREAD_BUFFER, 0, INDICATOR_BUFFER_SIZE, AverageSpread);
}

//--- Extract Raw Data From Indicators
double IndicatorProcessor::GetFastMAMA(int Shift)           { return NormalizeDouble(FastMAMA_Buffer[Shift]    , Digits()); }
double IndicatorProcessor::GetFastFAMA(int Shift)           { return NormalizeDouble(FastFAMA_Buffer[Shift]    , Digits()); }
double IndicatorProcessor::GetSlowMAMA(int Shift)           { return NormalizeDouble(SlowMAMA_Buffer[Shift]    , Digits()); }
double IndicatorProcessor::GetSlowFAMA(int Shift)           { return NormalizeDouble(SlowFAMA_Buffer[Shift]    , Digits()); }
double IndicatorProcessor::GetUpperSSB(int Shift)           { return NormalizeDouble(UpperSSB_Buffer[Shift]    , Digits()); }
double IndicatorProcessor::GetLowerSSB(int Shift)           { return NormalizeDouble(LowerSSB_Buffer[Shift]    , Digits()); }
double IndicatorProcessor::GetFilteredPrice(int Shift)      { return NormalizeDouble(FilteredPriceBuffer[Shift], Digits()); }
double IndicatorProcessor::GetBuyStopLossLevel(int Shift)   { return NormalizeDouble(BuyStopLossBuffer[Shift]  , Digits()); }
double IndicatorProcessor::GetSellStopLossLevel(int Shift)  { return NormalizeDouble(SellStopLossBuffer[Shift] , Digits()); }

int    IndicatorProcessor::GetOpenSpreadInPts(int Shift)    { return (int) (OpenSpread[Shift]);  }
int    IndicatorProcessor::GetHighSpreadInPts(int Shift)    { return (int) (HighSpread[Shift]);  }
int    IndicatorProcessor::GetLowSpreadInPts(int Shift)     { return (int) (LowSpread[Shift]);   }
int    IndicatorProcessor::GetCloseSpreadInPts(int Shift)   { return (int) (CloseSpread[Shift]); }
double IndicatorProcessor::GetAverageSpreadInPts(int Shift) { return AverageSpread[Shift];       }

//--- Preprocessed Raw Data From Indicators
int IndicatorProcessor::GetDiffFastFAMA_SlowFAMA_Pts(int Shift) {
   return PriceToPointCvt(MathAbs(FastFAMA_Buffer[Shift] - SlowFAMA_Buffer[Shift]));
}

bool IndicatorProcessor::HasTouchedUpperSSB(int Shift) { return GetBidPrice(Shift) > GetUpperSSB(Shift); }
bool IndicatorProcessor::HasTouchedLowerSSB(int Shift) { return GetBidPrice(Shift) < GetLowerSSB(Shift); }

double IndicatorProcessor::GetStopLossVolatilityInPrice(int Shift) {
   return GetFilteredPrice(Shift) - GetBuyStopLossLevel(Shift);
}

double IndicatorProcessor::GetTakeProfitVolatilityInPrice(int Shift) {
   return GetFilteredPrice(Shift) - GetLowerSSB(Shift);
}

int IndicatorProcessor::GetStopLossVolatilityInPts(int Shift) {
   return PriceToPointCvt(GetStopLossVolatilityInPrice(Shift));
}

int IndicatorProcessor::GetTakeProfitVolatilityInPts(int Shift) {
   return PriceToPointCvt(GetTakeProfitVolatilityInPrice(Shift));
}

//--- Additional Data
double IndicatorProcessor::GetBidPrice(int Shift) { return iClose(CurrencyPair, TimeFrame, CURRENT_BAR); }
double IndicatorProcessor::GetAskPrice(int Shift) { return GetBidPrice(Shift) + iSpread(CurrencyPair, TimeFrame, Shift); }
double IndicatorProcessor::GetCurrentBid(void)    { return SymbolInfoDouble(CurrencyPair, SYMBOL_BID); }
double IndicatorProcessor::GetCurrentAsk(void)    { return SymbolInfoDouble(CurrencyPair, SYMBOL_ASK); }