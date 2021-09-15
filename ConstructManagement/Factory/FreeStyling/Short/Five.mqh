#ifndef FIVE_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H
#define FIVE_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H

#include "../../ConstructFactory.mqh"

class FiveLevelNetShortFreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FiveLevelNetShortFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif