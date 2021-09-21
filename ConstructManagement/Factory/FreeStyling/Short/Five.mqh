#ifndef FIVE_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H
#define FIVE_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H

#include "../../../Construct/FreeStyling/Short/Five.mqh"
#include "../../ConstructFactory.mqh"

class FiveLevelNetShortFreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FiveLevelNetShortFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
};

#endif