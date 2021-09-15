#ifndef FOUR_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H
#define FOUR_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H

#include "../../ConstructFactory.mqh"

class FourLevelNetLongFreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FourLevelNetLongFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif