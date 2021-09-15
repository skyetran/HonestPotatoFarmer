#ifndef THREE_LEVEL_NET_SHORT_BIG_HEDGE_FACTORY_H
#define THREE_LEVEL_NET_SHORT_BIG_HEDGE_FACTORY_H

#include "../../ConstructFactory.mqh"

class ThreeLevelNetShortBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetShortBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif