#ifndef THREE_LEVEL_NET_SHORT_COUNTER_CONSTRUCT_MONITOR_H
#define THREE_LEVEL_NET_SHORT_COUNTER_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class ThreeLevelNetShortCounterConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetShortCounterConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif