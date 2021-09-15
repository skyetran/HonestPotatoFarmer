#ifndef FIVE_LEVEL_NET_SHORT_BIG_HEDGE_FACTORY_H
#define FIVE_LEVEL_NET_SHORT_BIG_HEDGE_FACTORY_H

#include "../../ConstructFactory.mqh"

class FiveLevelNetShortBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FiveLevelNetShortBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif