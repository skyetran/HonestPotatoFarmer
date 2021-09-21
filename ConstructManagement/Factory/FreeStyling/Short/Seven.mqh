#ifndef SEVEN_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H
#define SEVEN_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H

#include "../../../Construct/FreeStyling/Short/Seven.mqh"
#include "../../ConstructFactory.mqh"

class SevenLevelNetShortFreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SevenLevelNetShortFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
};

#endif