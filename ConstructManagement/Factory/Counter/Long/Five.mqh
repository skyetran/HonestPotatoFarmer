#ifndef FIVE_LEVEL_NET_LONG_COUNTER_FACTORY_H
#define FIVE_LEVEL_NET_LONG_COUNTER_FACTORY_H

#include "../../ConstructFactory.mqh"

class FiveLevelNetLongCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FiveLevelNetLongCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif