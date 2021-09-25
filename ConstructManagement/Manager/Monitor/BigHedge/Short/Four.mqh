#ifndef FOUR_LEVEL_NET_SHORT_BIG_HEDGE_CONSTRUCT_MONITOR_H
#define FOUR_LEVEL_NET_SHORT_BIG_HEDGE_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class FourLevelNetShortBigHedgeConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   FourLevelNetShortBigHedgeConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif