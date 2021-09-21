#ifndef SEVEN_LEVEL_NET_SHORT_BIG_HEDGE_FACTORY_H
#define SEVEN_LEVEL_NET_SHORT_BIG_HEDGE_FACTORY_H

#include "../../../Construct/BigHedge/Short/Seven.mqh"
#include "../../ConstructFactory.mqh"

class SevenLevelNetShortBigHedgeFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SevenLevelNetShortBigHedgeFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
};

#endif