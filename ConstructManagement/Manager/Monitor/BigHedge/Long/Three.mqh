#ifndef THREE_LEVEL_NET_LONG_BIG_HEDGE_CONSTRUCT_MONITOR_H
#define THREE_LEVEL_NET_LONG_BIG_HEDGE_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class ThreeLevelNetLongBigHedgeConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetLongBigHedgeConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif