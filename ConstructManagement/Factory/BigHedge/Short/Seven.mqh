#ifndef SEVEN_LEVEL_NET_SHORT_BIG_HEDGE_FACTORY_H
#define SEVEN_LEVEL_NET_SHORT_BIG_HEDGE_FACTORY_H

#include "../../ConstructFactory.mqh"

class SevenLevelNetShortBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SevenLevelNetShortBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif