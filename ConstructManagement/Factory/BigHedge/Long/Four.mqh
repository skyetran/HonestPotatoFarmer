#ifndef FOUR_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H
#define FOUR_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H

#include "../../ConstructFactory.mqh"

class FourLevelNetLongBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FourLevelNetLongBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif