#ifndef CONSTRUCT_MONITOR_H
#define CONSTRUCT_MONITOR_H

#include "../../Construct/Construct.mqh"
#include "../ConstructManager.mqh"

class ConstructMonitor : public ConstructManager
{
public:
   //--- Constructor
   ConstructMonitor(void);
   
   //--- Operations
   virtual void UpdateTradePool(Construct *construct) = NULL;
   virtual void UpdateFinance(Construct *construct) = NULL;
   virtual void UpdateRisk(Construct *construct) = NULL;

protected:
   //--- Attributes
   ConstructType *Type;
};

#endif