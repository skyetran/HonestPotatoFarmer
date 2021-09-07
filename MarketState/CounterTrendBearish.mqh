#ifndef COUNTER_TREND_BEARISH_H
#define COUNTER_TREND_BEARISH_H

#include "MarketState.mqh"

class CounterTrendBearish : public MarketState
{
public:
   //--- Main Constructor
   CounterTrendBearish(void);
   
   //--- Behavioural Logics
   void MonitorStateTransition(void) override;
   string GetStateName(void) override;
   
private:   
   bool IsCounterTrendBearishToWithTrendBearish(void);
   bool IsCounterTrendBearishToRanging(void);
   bool IsCounterTrendBearishToWithTrendBullish(void);
   
   bool OneTimeExecutionFlag;
   double GetLastLowestFastFAMA(void);
   
   double GetCapstoneLevel(void);
   double GetApexLevel(void);
   double GetStopLossLevel(void);
};

#endif