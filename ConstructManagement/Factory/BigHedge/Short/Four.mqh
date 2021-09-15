#ifndef FOUR_LEVEL_NET_SHORT_BIG_HEDGE_FACTORY_H
#define FOUR_LEVEL_NET_SHORT_BIG_HEDGE_FACTORY_H

#include "../../ConstructFactory.mqh"

class FourLevelNetShortBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FourLevelNetShortBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif