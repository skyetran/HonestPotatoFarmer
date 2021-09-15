#ifndef SIX_LEVEL_NET_SHORT_COUNTER_FACTORY_H
#define SIX_LEVEL_NET_SHORT_COUNTER_FACTORY_H

#include "../../ConstructFactory.mqh"

class SixLevelNetShortCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SixLevelNetShortCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif