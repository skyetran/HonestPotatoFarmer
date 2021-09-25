#ifndef SEVEN_LEVEL_NET_LONG_BIG_HEDGE_CONSTRUCT_MONITOR_H
#define SEVEN_LEVEL_NET_LONG_BIG_HEDGE_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class SevenLevelNetLongBigHedgeConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   SevenLevelNetLongBigHedgeConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif