#ifndef TWO_LEVEL_NET_LONG_BIG_HEDGE_CONSTRUCT_MONITOR_H
#define TWO_LEVEL_NET_LONG_BIG_HEDGE_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class TwoLevelNetLongBigHedgeConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   TwoLevelNetLongBigHedgeConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif