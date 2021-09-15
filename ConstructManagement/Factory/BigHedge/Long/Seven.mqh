#ifndef SEVEN_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H
#define SEVEN_LEVEL_NET_LONG_BIG_HEDGE_FACTORY_H

#include "../../ConstructFactory.mqh"

class SevenLevelNetLongBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SevenLevelNetLongBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif