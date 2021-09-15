#ifndef SIX_LEVEL_NET_LONG_COUNTER_FACTORY_H
#define SIX_LEVEL_NET_LONG_COUNTER_FACTORY_H

#include "../../ConstructFactory.mqh"

class SixLevelNetLongCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SixLevelNetLongCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif