#ifndef INDICATOR_PROCESSOR_H
#define INDICATOR_PROCESSOR_H

#include "GlobalConstants.mqh"
#include "GlobalHelperFunctions.mqh"

#define MAMA_BUFFER              2
#define FAMA_BUFFER              0

#define SSB_MIDDLE_BAND          0
#define SSB_UPPER_BAND           1
#define SSB_LOWER_BAND           2

#define OPEN_SPREAD_BUFFER       0
#define HIGH_SPREAD_BUFFER       1
#define LOW_SPREAD_BUFFER        2
#define CLOSE_SPREAD_BUFFER      3
#define AVERAGE_SPREAD_BUFFER    4

#define INDICATOR_BUFFER_SIZE    3

#define MIN_MAMA_FAST_LIMIT      0
#define MIN_MAMA_SLOW_LIMIT      0

#define MIN_ATTENUATION_PERIOD   2
#define MIN_ALPHA                0
#define MAX_ALPHA                1
#define MIN_BETA                 0
#define MAX_BETA                 1

class IndicatorProcessor
{
public:
   //--- Debug
   string GetDebugMessage(void);
   
   //--- Get Singleton Instance
   static IndicatorProcessor* GetInstance(void);
   
   //--- Indicator Init
   void FullInit(void);
   
   //--- Setters
   bool SetFastMAMAParameters(const double &FastLimit, const double &SlowLimit);
   bool SetSlowMAMAParameters(const double &FastLimit, const double &SlowLimit);
   bool SetSSBParameters(const int &AttenuationPeriod, const double &Alpha, const double &Beta);
   bool SetSSBStopLossParameters(const int &AttenuationPeriod, const double &Alpha, const double &Beta);
   
   //--- Update Indicator Buffer --- OnTick Function
   void Update(void);
   
   //--- Extract Raw Data From Indicators
   double GetFastMAMA(const int Shift) const;
   double GetFastFAMA(const int Shift) const;
   double GetSlowMAMA(const int Shift) const;
   double GetSlowFAMA(const int Shift) const;
   double GetUpperSSB(const int Shift) const;
   double GetLowerSSB(const int Shift) const;
   double GetFilteredPrice(const int Shift) const;
   double GetBuyStopLossLevel(const int Shift) const;
   double GetSellStopLossLevel(const int Shift) const;
   
   int    GetOpenSpreadInPts(const int Shift) const;
   int    GetHighSpreadInPts(const int Shift) const;
   int    GetLowSpreadInPts(const int Shift) const;
   int    GetCloseSpreadInPts(const int Shift) const;
   double GetAverageSpreadInPts(const int Shift) const;
   
   //--- Preprocessed Raw Data From Indicators
   int    GetDiffFastFAMA_SlowFAMA_Pts(const int Shift) const;
   bool   HasTouchedUpperSSB(const int Shift) const;
   bool   HasTouchedLowerSSB(const int Shift) const;
   double GetStopLossVolatilityInPrice(const int Shift) const;
   double GetTakeProfitVolatilityInPrice(const int Shift) const;
   int    GetStopLossVolatilityInPts(const int Shift) const;
   int    GetTakeProfitVolatilityInPts(const int Shift) const;
   
   //--- Additional Data
   double GetBidPrice(const int Shift) const;
   double GetAskPrice(const int Shift) const;
   double GetCurrentBid(void) const;
   double GetCurrentAsk(void) const;
   
private:
   //--- Indicator Handles
   int FastMAMA_Handle, SlowMAMA_Handle, SSB_Handle, SSB_StopLossHandle, SpreadHandle;
   
   //--- Indicator Buffer
   double FastMAMA_Buffer[], SlowMAMA_Buffer[];
   double FastFAMA_Buffer[], SlowFAMA_Buffer[];
   double UpperSSB_Buffer[], LowerSSB_Buffer[];
   double FilteredPriceBuffer[], BuyStopLossBuffer[], SellStopLossBuffer[];
   double OpenSpread[], HighSpread[], LowSpread[], CloseSpread[], AverageSpread[];
   
   //--- Parameters For Multi-Currency Pairs
   string CurrencyPair;
   ENUM_TIMEFRAMES TimeFrame;
   
   //--- Parameters For MAMA Indicator
   double FastMAMA_FastLimit, FastMAMA_SlowLimit;
   double SlowMAMA_FastLimit, SlowMAMA_SlowLimit;
   
   //--- Parameters For SSB Indicator
   int SSB_AttenuationPeriod, SSB_StopLossAttenuationPeriod;
   double SSB_Alpha, SSB_StopLossAlpha;
   double SSB_Beta , SSB_StopLossBeta;
   
   //--- Singleton Instance
   static IndicatorProcessor* Instance;
   
   // Main Constructor --- Singleton
   IndicatorProcessor(void);
   
   //--- Validation Checks
   bool IsMAMAValid(const double &FastLimit, const double &SlowLimit) const;
   bool IsSSBValid(const int &AttenuationPeriod, const double &Alpha, const double &Beta) const;
};

IndicatorProcessor* IndicatorProcessor::Instance = NULL;

#endif