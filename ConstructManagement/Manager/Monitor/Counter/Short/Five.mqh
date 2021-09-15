#ifndef FIVE_LEVEL_NET_SHORT_COUNTER_CONSTRUCT_MONITOR_H
#define FIVE_LEVEL_NET_SHORT_COUNTER_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class FiveLevelNetShortCounterConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   FiveLevelNetShortCounterConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif