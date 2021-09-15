#ifndef FIVE_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H
#define FIVE_LEVEL_NET_LONG_FREE_STYLING_FACTORY_H

#include "../../ConstructFactory.mqh"

class FiveLevelNetLongFreeStylingFactory : public ConstructFactory
{
public:
   //--- Constructor
   //--- Call To Register Type
   FiveLevelNetLongFreeStylingFactory(void);
   
   //--- Operations
   ConstructPreCheckInfo *PreCheck(Construct *construct) override;   
   Construct             *Create(void)                   override;
};

#endif