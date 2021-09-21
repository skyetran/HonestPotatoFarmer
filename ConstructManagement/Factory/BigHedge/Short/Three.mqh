#ifndef THREE_LEVEL_NET_SHORT_BIG_HEDGE_FACTORY_H
#define THREE_LEVEL_NET_SHORT_BIG_HEDGE_FACTORY_H

#include "../../../Construct/BigHedge/Short/Three.mqh"
#include "../../ConstructFactory.mqh"

class ThreeLevelNetShortBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetShortBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
};

#endif