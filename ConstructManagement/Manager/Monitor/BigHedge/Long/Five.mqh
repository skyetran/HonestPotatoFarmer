#ifndef FIVE_LEVEL_NET_LONG_BIG_HEDGE_CONSTRUCT_MONITOR_H
#define FIVE_LEVEL_NET_LONG_BIG_HEDGE_CONSTRUCT_MONITOR_H

#include "../../../../Construct/BigHedge/Long/Five.mqh"
#include "../../ConstructMonitor.mqh"

class FiveLevelNetLongBigHedgeConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   FiveLevelNetLongBigHedgeConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *InputConstruct) override;
   void UpdateFinance(Construct *InputConstruct)   override;
   void UpdateRisk(Construct *InputConstruct)      override;
};

#endif