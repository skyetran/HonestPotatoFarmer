#ifndef WITH_TREND_BEARISH_H
#define WITH_TREND_BEARISH_H

#include "MarketState.mqh"

class WithTrendBearish : public MarketState
{
public:
   //--- Main Constructor
   WithTrendBearish(void);
   
private:
   //--- Behavioral Logics
   void MonitorStateTransition(void)   override;
   void MonitorCurrentState(void)      override;
   void MonitorBoomerang(void)         override;
   void MonitorDownsideBoomerang(void) override;

   //--- Helper Functions: State Transition
   bool IsWithTrendBearishToRanging(void);
   bool IsWithTrendBearishToCounterTrendBearish(void);
   
   //--- Helper Functions: MonitorCurrentState
   void MonitorCapstoneLevel(void)                      override;
   void MonitorMaxFullyDefensiveAccumulationLevel(void) override;
   void MonitorBullishStopLossLevel(void)               override;
   void MonitorBearishStopLossLevel(void)               override;
   
   //--- Helper Functions: GetMaxFullyDefensiveAccumulationLevel
   double GetMaxIntervalSizeInPrice(void);
   int    GetMaxIntervalSizeInPts(void);
   
   //--- Helper Functions
   bool IsNewEntry(void) override;
   
   //--- Helper Functions: IsNewEntry
   bool IsFirstPositionNewEntry(void);
   bool IsOtherPositionNewEntry(void);
   
   //--- Utility Functions
   double GetBearishStopLossLevel(void);
};

#endif