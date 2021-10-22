#ifndef COUNTER_TREND_BULLISH_H
#define COUNTER_TREND_BULLISH_H

#include "MarketState.mqh"

class CounterTrendBullish : public MarketState
{
public:
   //--- Main Constructor
   CounterTrendBullish(void);
   
private:
   bool OneTimeExecutionFlag;

   //--- Behavioral Logics
   void   MonitorStateTransition(void) override;
   void   MonitorCurrentState(void)    override;
   void   MonitorBoomerang(void)       override;

   //--- Helper Functions: State Transition
   bool   IsCounterTrendBullishToWithTrendBullish(void);
   bool   IsCounterTrendBullishToRanging(void);
   bool   IsCounterTrendBullishToWithTrendBearish(void);
   double GetLastHighestFastFAMA(void);
   
   //--- Helper Functions: MonitorCurrentState
   void   MonitorCapstoneLevel(void)                      override;
   void   MonitorMaxFullyDefensiveAccumulationLevel(void) override;
   void   MonitorBullishStopLossLevel(void)               override;
   void   MonitorBearishStopLossLevel(void)               override;

   //--- Helper Functions: GetMaxFullyDefensiveAccumulationLevel
   double GetMaxIntervalSizeInPrice(void);
   int    GetMaxIntervalSizeInPts(void);

   //--- Helper Functions
   bool   IsNewEntry(void) override;
   
   //--- Helper Functions: IsNewEntry
   bool IsFirstPositionNewEntry(void);
   bool IsOtherPositionNewEntry(void);
};

#endif