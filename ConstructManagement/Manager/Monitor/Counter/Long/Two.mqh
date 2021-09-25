#ifndef TWO_LEVEL_NET_LONG_COUNTER_CONSTRUCT_MONITOR_H
#define TWO_LEVEL_NET_LONG_COUNTER_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class TwoLevelNetLongCounterConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   TwoLevelNetLongCounterConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif