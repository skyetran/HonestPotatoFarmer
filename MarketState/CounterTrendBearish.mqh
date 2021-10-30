#ifndef COUNTER_TREND_BEARISH_H
#define COUNTER_TREND_BEARISH_H

#include "MarketState.mqh"

class CounterTrendBearish : public MarketState
{
public:
   //--- Main Constructor
   CounterTrendBearish(void);
   
private:
   bool OneTimeExecutionFlag;
   
   //--- Behavioral Logics
   void   MonitorStateTransition(void)   override;
   void   MonitorCurrentState(void)      override;
   void   MonitorBoomerang(void)         override;
   void   MonitorDownsideBoomerang(void) override;
   
   //--- Helper Functions: State Transition
   bool   IsCounterTrendBearishToWithTrendBearish(void);
   bool   IsCounterTrendBearishToRanging(void);
   bool   IsCounterTrendBearishToWithTrendBullish(void);
   double GetLastLowestFastFAMA(void);
   
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
   
   //--- Utility Functions
   double GetBullishStopLossLevel(void);
};

#endif