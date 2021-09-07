#ifndef COUNTER_TREND_BULLISH_H
#define COUNTER_TREND_BULLISH_H

#include "MarketState.mqh"

class CounterTrendBullish : public MarketState
{
public:
   //--- Main Constructor
   CounterTrendBullish(void);
   
   //--- Behavioral Logics
   void MonitorStateTransition(void) override;
   string GetStateName(void) override;
   
private:
   bool IsCounterTrendBullishToWithTrendBullish(void);
   bool IsCounterTrendBullishToRanging(void);
   bool IsCounterTrendBullishToWithTrendBearish(void);
   
   bool OneTimeExecutionFlag;
   double GetLastHighestFastFAMA(void);
   
   double GetCapstoneLevel(void);
   double GetApexLevel(void);
   double GetStopLossLevel(void);
};

#endif