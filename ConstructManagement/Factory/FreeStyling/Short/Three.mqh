#ifndef THREE_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H
#define THREE_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H

#include "../../ConstructFactory.mqh"

class ThreeLevelNetShortFreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   ThreeLevelNetShortFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif