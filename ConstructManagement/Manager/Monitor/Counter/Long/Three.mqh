#ifndef THREE_LEVEL_NET_LONG_COUNTER_CONSTRUCT_MONITOR_H
#define THREE_LEVEL_NET_LONG_COUNTER_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class ThreeLevelNetLongCounterConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetLongCounterConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif