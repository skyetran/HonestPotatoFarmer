#ifndef SIX_LEVEL_NET_LONG_COUNTER_CONSTRUCT_MONITOR_H
#define SIX_LEVEL_NET_LONG_COUNTER_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class SixLevelNetLongCounterConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   SixLevelNetLongCounterConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif