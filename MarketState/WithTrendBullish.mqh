#ifndef WITH_TREND_BULLISH_H
#define WITH_TREND_BULLISH_H

#include "MarketState.mqh"

class WithTrendBullish : public MarketState
{
public:
   //--- Behavioral Logics
   void MonitorStateTransition(void) override;
   string GetStateName(void) override;
   
private:
   bool IsWithTrendBullishToRanging(void);
   bool IsWithTrendBullishToCounterTrendBullish(void);
   
   double GetCapstoneLevel(void);
   double GetApexLevel(void);
   double GetStopLossLevel(void);
};

#endif