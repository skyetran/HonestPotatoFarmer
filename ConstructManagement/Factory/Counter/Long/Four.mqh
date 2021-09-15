#ifndef FOUR_LEVEL_NET_LONG_COUNTER_FACTORY_H
#define FOUR_LEVEL_NET_LONG_COUNTER_FACTORY_H

#include "../../ConstructFactory.mqh"

class FourLevelNetLongCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FourLevelNetLongCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif