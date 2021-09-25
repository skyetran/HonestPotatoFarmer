#ifndef FOUR_LEVEL_NET_LONG_BIG_HEDGE_CONSTRUCT_MONITOR_H
#define FOUR_LEVEL_NET_LONG_BIG_HEDGE_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class FourLevelNetLongBigHedgeConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   FourLevelNetLongBigHedgeConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif