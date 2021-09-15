#ifndef FOUR_LEVEL_NET_SHORT_COUNTER_FACTORY_H
#define FOUR_LEVEL_NET_SHORT_COUNTER_FACTORY_H

#include "../../ConstructFactory.mqh"

class FourLevelNetShortCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FourLevelNetShortCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif