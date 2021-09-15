#ifndef FOUR_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H
#define FOUR_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H

#include "../../ConstructFactory.mqh"

class FourLevelNetShortFreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FourLevelNetShortFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif