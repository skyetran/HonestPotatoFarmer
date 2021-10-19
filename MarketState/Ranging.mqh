#ifndef RANGING_H
#define RANGING_H

#include "MarketState.mqh"

class Ranging : public MarketState
{
public:
   //--- Main Constructor
   Ranging(void);
   
private:
   //--- Behavioral Logics
   void   MonitorStateTransition(void) override;
   void   MonitorCurrentState(void)    override;
   void   MonitorBoomerang(void)       override;

   //--- Helper Functions For State Transition
   bool   IsRangingToWithTrendBullish(void);
   bool   IsRangingToWithTrendBearish(void);
   
   double GetTopCapstoneLevel(void);
   double GetTopApexLevel(void);
   
   double GetBotCapstoneLevel(void);
   double GetBotApexLevel(void);
   
   //--- Helper Functions: MonitorCurrentState
   void   MonitorCapstoneLevel(void)                      override;
   void   MonitorMaxFullyDefensiveAccumulationLevel(void) override;
   void   MonitorBullishStopLossLevel(void)               override;
   void   MonitorBearishStopLossLevel(void)               override;
   
   //--- Helper Functions
   bool   IsNewEntry(void) override;
};

#endif