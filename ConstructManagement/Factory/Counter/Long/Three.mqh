#ifndef THREE_LEVEL_NET_LONG_COUNTER_FACTORY_H
#define THREE_LEVEL_NET_LONG_COUNTER_FACTORY_H

#include "../../ConstructFactory.mqh"

class ThreeLevelNetLongCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetLongCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif