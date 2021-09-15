#ifndef SIX_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H
#define SIX_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H

#include "../../ConstructFactory.mqh"

class SixLevelNetLongBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SixLevelNetLongBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif