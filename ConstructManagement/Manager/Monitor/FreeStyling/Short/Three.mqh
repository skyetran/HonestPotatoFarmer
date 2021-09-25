#ifndef THREE_LEVEL_NET_SHORT_FREE_STYLING_CONSTRUCT_MONITOR_H
#define THREE_LEVEL_NET_SHORT_FREE_STYLING_CONSTRUCT_MONITOR_H

#include "../../ConstructMonitor.mqh"

class ThreeLevelNetShortFreeStylingConstructMonitor : public ConstructMonitor
{
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetShortFreeStylingConstructMonitor(void);
   
   //--- Operations
   void UpdateTradePool(Construct *construct) override;
   void UpdateFinance(Construct *construct)   override;
   void UpdateRisk(Construct *construct)      override;
};

#endif