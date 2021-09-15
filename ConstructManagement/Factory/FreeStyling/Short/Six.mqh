#ifndef SIX_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H
#define SIX_LEVEL_NET_SHORT_FREE_STYLING_FACTORY_H

#include "../../ConstructFactory.mqh"

class SixLevelNetShortFreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   SixLevelNetShortFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif