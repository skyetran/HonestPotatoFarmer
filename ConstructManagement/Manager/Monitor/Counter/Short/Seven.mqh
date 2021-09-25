#ifndef SEVEN_LEVEL_NET_SHORT_COUNTER_CONSTRUCT_MONITOR_H
#define SEVEN_LEVEL_NET_SHORT_COUNTER_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class SevenLevelNetShortCounterConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   SevenLevelNetShortCounterConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif