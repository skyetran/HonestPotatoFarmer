#ifndef THREE_LEVEL_NET_SHORT_COUNTER_FACTORY_H
#define THREE_LEVEL_NET_SHORT_COUNTER_FACTORY_H

#include "../../ConstructFactory.mqh"

class ThreeLevelNetShortCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetShortCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif