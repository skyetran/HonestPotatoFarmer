#ifndef INDICATOR_PROCESSOR_H
#define INDICATOR_PROCESSOR_H

#include "GlobalConstants.mqh"
#include "GlobalHelperFunctions.mqh"

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
   void SetSymbol(string CurrencyPairName);
   void SetTimeFrame(ENUM_TIMEFRAMES ChartTimeFrame);
   bool SetFastMAMAParameters(const double &FastLimit, const double &SlowLimit);
   bool SetSlowMAMAParameters(const double &FastLimit, const double &SlowLimit);
   bool SetSSBParameters(const int &AttenuationPeriod, const double &Alpha, const double &Beta);
   bool SetSSBStopLossParameters(const int &AttenuationPeriod, const double &Alpha, const double &Beta);
   
   //--- Getters
   string GetSymbol(void);
   ENUM_TIMEFRAMES GetTimeFrame(void);
   
   //--- Update Indicator Buffer --- OnTick Function
   void Update(void);
   
   //--- Extract Raw Data From Indicators
   double GetFastMAMA(int Shift);
   double GetFastFAMA(int Shift);
   double GetSlowMAMA(int Shift);
   double GetSlowFAMA(int Shift);
   double GetUpperSSB(int Shift);
   double GetLowerSSB(int Shift);
   double GetFilteredPrice(int Shift);
   double GetBuyStopLossLevel(int Shift);
   double GetSellStopLossLevel(int Shift);
   
   //--- Preprocessed Raw Data From Indicators
   int GetDiffFastFAMA_SlowFAMA_Pts(int Shift);
   bool HasTouchedUpperSSB(int Shift);
   bool HasTouchedLowerSSB(int Shift);
   
   //--- Additional Data
   double GetBidPrice(int Shift);
   double GetAskPrice(int Shift);
   double GetCurrentBid(void);
   double GetCurrentAsk(void);
   
private:
   //--- Indicator Handles
   int FastMAMA_Handle, SlowMAMA_Handle, SSB_Handle, SSB_StopLossHandle;
   
   //--- Indicator Buffer
   double FastMAMA_Buffer[], SlowMAMA_Buffer[];
   double FastFAMA_Buffer[], SlowFAMA_Buffer[];
   double UpperSSB_Buffer[], LowerSSB_Buffer[];
   double FilteredPriceBuffer[], BuyStopLossBuffer[], SellStopLossBuffer[];
   
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
   
   //--- Single Instance
   static IndicatorProcessor* Instance;
   
   // Main Constructor --- Singleton
   IndicatorProcessor(void);
   
   //--- Validation Checks
   bool IsMAMAValid(const double &FastLimit, const double &SlowLimit);
   bool IsSSBValid(const int &AttenuationPeriod, const double &Alpha, const double &Beta);
};

IndicatorProcessor* IndicatorProcessor::Instance = NULL;

#endif