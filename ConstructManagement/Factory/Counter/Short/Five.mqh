#ifndef FIVE_LEVEL_NET_SHORT_COUNTER_FACTORY_H
#define FIVE_LEVEL_NET_SHORT_COUNTER_FACTORY_H

#include "../../ConstructFactory.mqh"

class FiveLevelNetShortCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FiveLevelNetShortCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif