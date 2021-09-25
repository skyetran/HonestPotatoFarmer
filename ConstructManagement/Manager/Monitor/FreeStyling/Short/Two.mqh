#ifndef TWO_LEVEL_NET_SHORT_FREE_STYLING_CONSTRUCT_MONITOR_H
#define TWO_LEVEL_NET_SHORT_FREE_STYLING_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class TwoLevelNetShortFreeStylingConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   TwoLevelNetShortFreeStylingConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif