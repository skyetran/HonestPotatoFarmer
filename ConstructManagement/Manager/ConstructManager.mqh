#ifndef CONSTRUCT_MANAGER_H
#define CONSTRUCT_MANAGER_H

#include "../../General/IndicatorProcessor.mqh"

class ConstructManager
{
public:
   //--- Main Constructor
   ConstructManager(void);
   
   //--- Destructor
   ~ConstructManager(void);
   
protected:
   IndicatorProcessor *IP;
};

#endif