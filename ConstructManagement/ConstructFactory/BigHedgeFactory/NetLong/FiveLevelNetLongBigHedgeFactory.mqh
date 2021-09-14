#ifndef FIVE_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H
#define FIVE_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H

#include "../../ConstructFactory.mqh"

class FiveLevelNetLongBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FiveLevelNetLongBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif