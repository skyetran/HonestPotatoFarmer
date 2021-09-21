#ifndef FOUR_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H
#define FOUR_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H

#include "../../../Construct/FreeStyling/Long/Four.mqh"
#include "../../ConstructFactory.mqh"

class FourLevelNetLongFreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FourLevelNetLongFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
};

#endif