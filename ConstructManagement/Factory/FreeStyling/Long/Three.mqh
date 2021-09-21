#ifndef THREE_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H
#define THREE_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H

#include "../../../Construct/FreeStyling/Long/Three.mqh"
#include "../../ConstructFactory.mqh"

class ThreeLevelNetLongFreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetLongFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(ConstructParameters *InputParameters)                                 override;
   bool                   Validate(ConstructParameters *InputParameters, const int InputEntryPositionID) override;
   Construct             *Create(ConstructParameters *InputParameters, const int InputEntryPositionID)   override;
};

#endif