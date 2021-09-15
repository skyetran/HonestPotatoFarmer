#ifndef SEVEN_LEVEL_NET_LONG_COUNTER_CONSTRUCT_MONITOR_H
#define SEVEN_LEVEL_NET_LONG_COUNTER_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class SevenLevelNetLongCounterConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   SevenLevelNetLongCounterConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif