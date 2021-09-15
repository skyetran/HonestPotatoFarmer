#ifndef FIVE_LEVEL_NET_LONG_FREE_STYLING_CONSTRUCT_MONITOR_H
#define FIVE_LEVEL_NET_LONG_FREE_STYLING_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class FiveLevelNetLongFreeStylingConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   FiveLevelNetLongFreeStylingConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif