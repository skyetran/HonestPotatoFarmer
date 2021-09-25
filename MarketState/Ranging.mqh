#ifndef RANGING_H
#define RANGING_H

#include "MarketState.mqh"

class Ranging : public MarketState
{
public:
   //--- Behavioral Logics
   void MonitorStateTransition(void) override;
   string GetStateName(void) override;
   
private:
   //--- Helper Functions For State Transition
   bool IsRangingToWithTrendBullish(void);
   bool IsRangingToWithTrendBearish(void);
   
   double GetTopCapstoneLevel(void);
   double GetTopApexLevel(void);
   
   double GetBotCapstoneLevel(void);
   double GetBotApexLevel(void);
};

#endif