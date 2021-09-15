#ifndef THREE_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H
#define THREE_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H

#include "../../ConstructFactory.mqh"

class ThreeLevelNetLongBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetLongBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif