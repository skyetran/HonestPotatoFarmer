#ifndef FIVE_LEVEL_NET_LONG_COUNTER_CONSTRUCT_MONITOR_H
#define FIVE_LEVEL_NET_LONG_COUNTER_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class FiveLevelNetLongCounterConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   FiveLevelNetLongCounterConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif