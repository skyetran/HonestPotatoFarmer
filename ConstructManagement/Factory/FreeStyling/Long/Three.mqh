#ifndef THREE_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H
#define THREE_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H

#include "../../ConstructFactory.mqh"

class ThreeLevelNetLongFreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetLongFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif