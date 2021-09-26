#ifndef WITH_TREND_BEARISH_H
#define WITH_TREND_BEARISH_H

#include "MarketState.mqh"

class WithTrendBearish : public MarketState
{
public:
   //--- Behavioral Logics
   void MonitorStateTransition(void) override;
   string GetStateName(void) override;
   
private:
   bool IsWithTrendBearishToRanging(void);
   bool IsWithTrendBearishToCounterTrendBearish(void);
   
   int GetMaxIntervalSize(void);
   int GetStopLossSize(void);
   
   double GetStopLossLevel(void);
   double GetCapstoneLevel(void);
};

#endif