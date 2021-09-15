#ifndef SEVEN_LEVEL_NET_SHORT_COUNTER_FACTORY_H
#define SEVEN_LEVEL_NET_SHORT_COUNTER_FACTORY_H

#include "../../ConstructFactory.mqh"

class SevenLevelNetShortCounterFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SevenLevelNetShortCounterFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif