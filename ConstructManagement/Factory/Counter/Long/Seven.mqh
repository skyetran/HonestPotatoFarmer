#ifndef SEVEN_LEVEL_NET_LONG_COUNTER_FACTORY_H
#define SEVEN_LEVEL_NET_LONG_COUNTER_FACTORY_H

#include "../../ConstructFactory.mqh"

class SevenLevelNetLongCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SevenLevelNetLongCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif