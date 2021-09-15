#ifndef SIX_LEVEL_NET_SHORT_BIG_HEDGE_FACTORY_H
#define SIX_LEVEL_NET_SHORT_BIG_HEDGE_FACTORY_H

#include "../../ConstructFactory.mqh"

class SixLevelNetShortBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SixLevelNetShortBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif